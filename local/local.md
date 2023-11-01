### Effigy Coding Standards

Any code submissions that do not meet our coding standards are likely to be rejected, or at the very least, have a maintainer request changes on your PR. Save time and follow these standards from the start:

In an effort to make contributing easier to do, Black Major has started a modularity folder, https://github.com/effigy-se/effigy-se/tree/main/local.
Ideally, any content that can be written that is wholelly independant of /tg/station's content, should be included in this modularity folder
and put into the associated folder that it would have appeared in among the standard files.

Ideally, the point of this is to make it slightly easier to differentiate Effigy content from /tg/station content.

When should you use this?
Mostly for Effigy exclusive stuff, otherwise if you need to modify a base file for any reason or if it is expected to be a part of upstream as well, write it in the base files with the following standards/policies/guidelines in the meantime:

* If it is something like a bugfix that /tg/station would want (the codebase we use, also called upstream), code it in their code and make the PR to them. We regularly update to maintain parity with the upstream master. They would want any general gameplay bugfixes, and things that are obviously intended to work one way, but do not. They do not have any of our fluff species (vulp, akula, tajaran, etc) or additional content so do not make PRs related to that.
* Never edit stock /tg/ DMI files. If you are confused about which .dmi files we have added and which were there originally, refer to their repository and and see if they exist (https://github.com/tgstation/tgstation). All PRs with edits to stock .DMI files may be rejected.
* When changing any code in any stock /tg/ .DM file, you must mark your changes:
    * For single-line changes: // EffigyEdit Change - Explanation (Change can also be Add for new lines or Remove if you are commenting the line out.)
    * For multi-line additions: // EffigyEdit Change - Explanation and then at the bottom of your changes, // EffigyEdit Change/Add/Remove End
    * For multi-line removals: Use a block comment (/\* xxx \*/) to comment out the existing code block (do not modify whitespace more than necessary) and at the start, it should contain
	/* EffigyEdit Remove - Explanation
	<code here>
	<code here>
	*/// EffigyEdit Remove End
 
* Change whitespace as little as possible. Do not randomly add/remove whitespace.
* Any new files should preferrably go into the local folder following the file structure of where it would be placed normally.
* Do not make changes to base icon files. New icon files should go into /local and code should be changed to point to the new file.
* Map changes must be in tgm format. See the [Mapmerge2 Readme] for details, or use [StrongDMM] which can automatically save maps as tgm.
