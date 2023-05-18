/// The scaling method to show the world in, e.g. nearest neighbor
/datum/preference/choiced/scaling_method
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "scaling_method"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/scaling_method/create_default_value()
	return SCALING_METHOD_NORMAL

/datum/preference/choiced/scaling_method/init_possible_values()
	return list(SCALING_METHOD_NORMAL)

/datum/preference/choiced/scaling_method/apply_to_client(client/client, value)
	client?.view_size?.setZoomMode()

/datum/asset/simple/namespaced/effigy_ui
	assets = list(
		"ChakraPetch-Medium.ttf" = 'packages/ux/fonts/ChakraPetch-Medium.ttf',
		"ChakraPetch-MediumItalic.ttf" = 'packages/ux/fonts/ChakraPetch-MediumItalic.ttf',
		"ChakraPetch-SemiBold.ttf" = 'packages/ux/fonts/ChakraPetch-SemiBold.ttf',
		"ChakraPetch-SemiBoldItalic.ttf" = 'packages/ux/fonts/ChakraPetch-SemiBoldItalic.ttf',
		"ChakraPetch-Bold.ttf" = 'packages/ux/fonts/ChakraPetch-Bold.ttf',
		"ChakraPetch-BoldItalic.ttf" = 'packages/ux/fonts/ChakraPetch-BoldItalic.ttf',
		"IBMPlexSans-Medium.ttf" = 'packages/ux/fonts/IBMPlexSans-Medium.ttf',
		"IBMPlexSans-MediumItalic.ttf" = 'packages/ux/fonts/IBMPlexSans-MediumItalic.ttf',
		"IBMPlexSans-SemiBold.ttf" = 'packages/ux/fonts/IBMPlexSans-SemiBold.ttf',
		"IBMPlexSans-SemiBoldItalic.ttf" = 'packages/ux/fonts/IBMPlexSans-SemiBoldItalic.ttf',
		"IBMPlexSans-Bold.ttf" = 'packages/ux/fonts/IBMPlexSans-Bold.ttf',
		"IBMPlexSans-BoldItalic.ttf" = 'packages/ux/fonts/IBMPlexSans-BoldItalic.ttf',
		"TitilliumWeb-Regular.ttf" = 'packages/ux/fonts/TitilliumWeb-Regular.ttf',
		"TitilliumWeb-Italic.ttf" = 'packages/ux/fonts/TitilliumWeb-Italic.ttf',
		"TitilliumWeb-SemiBold.ttf" = 'packages/ux/fonts/TitilliumWeb-SemiBold.ttf',
		"TitilliumWeb-SemiBoldItalic.ttf" = 'packages/ux/fonts/TitilliumWeb-SemiBoldItalic.ttf',
		"TitilliumWeb-Bold.ttf" = 'packages/ux/fonts/TitilliumWeb-Bold.ttf',
		"TitilliumWeb-BoldItalic.ttf" = 'packages/ux/fonts/TitilliumWeb-BoldItalic.ttf',
		"UbuntuMono-Regular.ttf" = 'packages/ux/fonts/UbuntuMono-Regular.ttf',
		"UbuntuMono-Italic.ttf" = 'packages/ux/fonts/UbuntuMono-Italic.ttf',
		"UbuntuMono-Bold.ttf" = 'packages/ux/fonts/UbuntuMono-Bold.ttf',
		"UbuntuMono-BoldItalic.ttf" = 'packages/ux/fonts/UbuntuMono-BoldItalic.ttf',
	)

var/list/extra_resources = list(\
	'packages/ux/fonts/ChakraPetch-Medium.ttf',
	'packages/ux/fonts/ChakraPetch-MediumItalic.ttf',
	'packages/ux/fonts/ChakraPetch-SemiBold.ttf',
	'packages/ux/fonts/ChakraPetch-SemiBoldItalic.ttf',
	'packages/ux/fonts/ChakraPetch-Bold.ttf',
	'packages/ux/fonts/ChakraPetch-BoldItalic.ttf',
	'packages/ux/fonts/IBMPlexSans-Medium.ttf',
	'packages/ux/fonts/IBMPlexSans-MediumItalic.ttf',
	'packages/ux/fonts/IBMPlexSans-SemiBold.ttf',
	'packages/ux/fonts/IBMPlexSans-SemiBoldItalic.ttf',
	'packages/ux/fonts/IBMPlexSans-Bold.ttf',
	'packages/ux/fonts/IBMPlexSans-BoldItalic.ttf',
	'packages/ux/fonts/TitilliumWeb-Regular.ttf',
	'packages/ux/fonts/TitilliumWeb-Italic.ttf',
	'packages/ux/fonts/TitilliumWeb-SemiBoldItalic.ttf',
	'packages/ux/fonts/TitilliumWeb-Bold.ttf',
	'packages/ux/fonts/TitilliumWeb-BoldItalic.ttf',
	'packages/ux/fonts/UbuntuMono-Regular.ttf',
	'packages/ux/fonts/UbuntuMono-Italic.ttf',
	'packages/ux/fonts/UbuntuMono-Bold.ttf',
	'packages/ux/fonts/UbuntuMono-BoldItalic.ttf'
)
