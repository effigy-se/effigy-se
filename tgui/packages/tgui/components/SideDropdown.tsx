import { createPopper, VirtualElement } from '@popperjs/core';
import { classes } from 'common/react';
import { Component, findDOMfromVNode, InfernoNode, render } from 'inferno';
import { Box, BoxProps } from './Box';
import { Button } from './Button';
import { Icon } from './Icon';
import { Stack } from './Stack';

export interface DropdownEntry {
  displayText: string | number | InfernoNode;
  value: string | number | Enumerator;
}

type SideDropdownUniqueProps = {
  options: string[] | DropdownEntry[];
  icon?: string;
  iconRotation?: number;
  clipSelectedText?: boolean;
  width?: string;
  menuWidth?: string;
  over?: boolean;
  color?: string;
  nochevron?: boolean;
  displayText?: string | number | InfernoNode;
  onClick?: (event) => void;
  // you freaks really are just doing anything with this shit
  selected?: any;
  onSelected?: (selected: any) => void;
  buttons?: boolean;
};

export type SideDropdownProps = BoxProps & SideDropdownUniqueProps;

const DEFAULT_OPTIONS = {
  placement: 'left-start',
  modifiers: [
    {
      name: 'eventListeners',
      enabled: false,
    },
  ],
};
const NULL_RECT: DOMRect = {
  width: 0,
  height: 0,
  top: 0,
  right: 0,
  bottom: 0,
  left: 0,
  x: 0,
  y: 0,
  toJSON: () => null,
} as const;

type SideDropdownState = {
  selected?: string;
  open: boolean;
};

const SIDE_DROPDOWN_DEFAULT_CLASSNAMES = 'Layout SideDropdown__menu';
const SIDE_DROPDOWN_SCROLL_CLASSNAMES = 'Layout SideDropdown__menu-scroll';

export class SideDropdown extends Component<
  SideDropdownProps,
  SideDropdownState
> {
  static renderedMenu: HTMLDivElement | undefined;
  static singletonPopper: ReturnType<typeof createPopper> | undefined;
  static currentOpenMenu: Element | undefined;
  static virtualElement: VirtualElement = {
    getBoundingClientRect: () =>
      SideDropdown.currentOpenMenu?.getBoundingClientRect() ?? NULL_RECT,
  };
  menuContents: any;
  state: SideDropdownState = {
    open: false,
    selected: this.props.selected,
  };

  handleClick = () => {
    if (this.state.open) {
      this.setOpen(false);
    }
  };

  getDOMNode() {
    return findDOMfromVNode(this.$LI, true);
  }

  componentDidMount() {
    const domNode = this.getDOMNode();

    if (!domNode) {
      return;
    }
  }

  openMenu() {
    let renderedMenu = SideDropdown.renderedMenu;
    if (renderedMenu === undefined) {
      renderedMenu = document.createElement('div');
      renderedMenu.className = SIDE_DROPDOWN_DEFAULT_CLASSNAMES;
      document.body.appendChild(renderedMenu);
      SideDropdown.renderedMenu = renderedMenu;
    }

    const domNode = this.getDOMNode()!;
    SideDropdown.currentOpenMenu = domNode;

    renderedMenu.scrollTop = 0;
    renderedMenu.style.width =
      this.props.menuWidth ||
      // Hack, but domNode should *always* be the parent control meaning it will have width
      // @ts-ignore
      `${domNode.offsetWidth}px`;
    renderedMenu.style.opacity = '1';
    renderedMenu.style.pointerEvents = 'auto';

    // ie hack
    // ie has this bizarre behavior where focus just silently fails if the
    // element being targeted "isn't ready"
    // 400 is probably way too high, but the lack of hotloading is testing my
    // patience on tuning it
    // I'm beyond giving a shit at this point it fucking works whatever
    setTimeout(() => {
      SideDropdown.renderedMenu?.focus();
    }, 400);
    this.renderMenuContent();
  }

  closeMenu() {
    if (SideDropdown.currentOpenMenu !== this.getDOMNode()) {
      return;
    }

    SideDropdown.currentOpenMenu = undefined;
    SideDropdown.renderedMenu!.style.opacity = '0';
    SideDropdown.renderedMenu!.style.pointerEvents = 'none';
  }

  componentWillUnmount() {
    this.closeMenu();
    this.setOpen(false);
  }

  renderMenuContent() {
    const renderedMenu = SideDropdown.renderedMenu;
    if (!renderedMenu) {
      return;
    }
    if (renderedMenu.offsetHeight > 200) {
      renderedMenu.className = SIDE_DROPDOWN_SCROLL_CLASSNAMES;
    } else {
      renderedMenu.className = SIDE_DROPDOWN_DEFAULT_CLASSNAMES;
    }

    const { options = [] } = this.props;
    const ops = options.map((option) => {
      let value, displayText;

      if (typeof option === 'string') {
        displayText = option;
        value = option;
      } else if (option !== null) {
        displayText = option.displayText;
        value = option.value;
      }

      return (
        <div
          key={value}
          className={classes([
            'SideDropdown__menuentry',
            this.state.selected === value && 'selected',
          ])}
          onClick={() => {
            this.setSelected(value);
          }}>
          {displayText}
        </div>
      );
    });

    const to_render = ops.length ? ops : 'No Options Found';

    render(
      <div>{to_render}</div>,
      renderedMenu,
      () => {
        let singletonPopper = SideDropdown.singletonPopper;
        if (singletonPopper === undefined) {
          singletonPopper = createPopper(
            SideDropdown.virtualElement,
            renderedMenu!,
            {
              ...DEFAULT_OPTIONS,
              placement: 'right-end',
            }
          );

          SideDropdown.singletonPopper = singletonPopper;
        } else {
          singletonPopper.setOptions({
            ...DEFAULT_OPTIONS,
            placement: 'right-end',
          });

          singletonPopper.update();
        }
      },
      this.context
    );
  }

  setOpen(open: boolean) {
    this.setState((state) => ({
      ...state,
      open,
    }));
    if (open) {
      setTimeout(() => {
        this.openMenu();
        window.addEventListener('click', this.handleClick);
      });
    } else {
      this.closeMenu();
      window.removeEventListener('click', this.handleClick);
    }
  }

  setSelected(selected: string) {
    this.setState((state) => ({
      ...state,
      selected,
    }));
    this.setOpen(false);
    if (this.props.onSelected) {
      this.props.onSelected(selected);
    }
  }

  getOptionValue(option): string {
    return typeof option === 'string' ? option : option.value;
  }

  getSelectedIndex(): number {
    const selected = this.state.selected || this.props.selected;
    const { options = [] } = this.props;

    return options.findIndex((option) => {
      return this.getOptionValue(option) === selected;
    });
  }

  toPrevious(): void {
    if (this.props.options.length < 1) {
      return;
    }

    let selectedIndex = this.getSelectedIndex();
    const startIndex = 0;
    const endIndex = this.props.options.length - 1;

    const hasSelected = selectedIndex >= 0;
    if (!hasSelected) {
      selectedIndex = startIndex;
    }

    const previousIndex =
      selectedIndex === startIndex ? endIndex : selectedIndex - 1;

    this.setSelected(this.getOptionValue(this.props.options[previousIndex]));
  }

  toNext(): void {
    if (this.props.options.length < 1) {
      return;
    }

    let selectedIndex = this.getSelectedIndex();
    const startIndex = 0;
    const endIndex = this.props.options.length - 1;

    const hasSelected = selectedIndex >= 0;
    if (!hasSelected) {
      selectedIndex = endIndex;
    }

    const nextIndex =
      selectedIndex === endIndex ? startIndex : selectedIndex + 1;

    this.setSelected(this.getOptionValue(this.props.options[nextIndex]));
  }

  render() {
    const { props } = this;
    const {
      icon,
      iconRotation,
      iconSpin,
      clipSelectedText = true,
      color = 'default',
      dropdownStyle,
      over,
      nochevron,
      width,
      onClick,
      onSelected,
      selected,
      disabled,
      displayText,
      buttons,
      ...boxProps
    } = props;
    const { className, ...rest } = boxProps;

    const adjustedOpen = over ? !this.state.open : this.state.open;

    return (
      <Stack fill>
        <Stack.Item width={width}>
          <Box
            width={'100%'}
            className={classes([
              'SideDropdown__control',
              'Button',
              'Button--color--' + color,
              disabled && 'Button--disabled',
              className,
            ])}
            onClick={(event) => {
              if (disabled && !this.state.open) {
                return;
              }
              this.setOpen(!this.state.open);
              if (onClick) {
                onClick(event);
              }
            }}
            {...rest}>
            {icon && (
              <Icon
                name={icon}
                rotation={iconRotation}
                spin={iconSpin}
                mr={1}
              />
            )}
            <span
              className="SideDropdown__selected-text"
              style={{
                overflow: clipSelectedText ? 'hidden' : 'visible',
              }}>
              {displayText || this.state.selected}
            </span>
            {nochevron || (
              <span className="SideDropdown__arrow-button">
                <Icon name={adjustedOpen ? 'chevron-up' : 'chevron-down'} />
              </span>
            )}
          </Box>
        </Stack.Item>
        {buttons && (
          <>
            <Stack.Item height={'100%'}>
              <Button
                height={'100%'}
                icon="chevron-left"
                disabled={disabled}
                onClick={() => {
                  if (disabled) {
                    return;
                  }

                  this.toPrevious();
                }}
              />
            </Stack.Item>
            <Stack.Item height={'100%'}>
              <Button
                height={'100%'}
                icon="chevron-right"
                disabled={disabled}
                onClick={() => {
                  if (disabled) {
                    return;
                  }

                  this.toNext();
                }}
              />
            </Stack.Item>
          </>
        )}
      </Stack>
    );
  }
}
