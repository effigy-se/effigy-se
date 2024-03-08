//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		// EffigyEdit Add - Maps
		#include "map_files\FoxHoleStation\foxholestation.dmm"
		#include "map_files\RimPoint\RimPoint.dmm"
		#include "map_files\SigmaOctantis\SigmaOctantis.dmm"
		// EffigyEdit Add End
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
