; ModuleID = 'typemaps.arm64-v8a.ll'
source_filename = "typemaps.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.TypeMapJava = type {
	i32, ; uint32_t module_index
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_name_index
}

%struct.TypeMapModule = type {
	[16 x i8], ; uint8_t module_uuid[16]
	i32, ; uint32_t entry_count
	i32, ; uint32_t duplicate_count
	ptr, ; TypeMapModuleEntry map
	ptr, ; TypeMapModuleEntry duplicate_map
	ptr, ; char* assembly_name
	ptr, ; MonoImage image
	i32, ; uint32_t java_name_width
	ptr ; uint8_t java_map
}

%struct.TypeMapModuleEntry = type {
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_map_index
}

@map_module_count = dso_local local_unnamed_addr constant i32 2, align 4

@java_type_count = dso_local local_unnamed_addr constant i32 44, align 4

; Managed modules map
@map_modules = dso_local local_unnamed_addr global [2 x %struct.TypeMapModule] [
	%struct.TypeMapModule {
		[16 x i8] c">\01\0E\FA\F9\9D3G\B5\13\ED}\9C\94\0E\06", ; module_uuid: fa0e013e-9df9-4733-b513-ed7d9c940e06
		i32 1, ; uint32_t entry_count (0x1)
		i32 0, ; uint32_t duplicate_count (0x0)
		ptr @module0_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.0_assembly_name, ; assembly_name: StereoKitInk_Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width (0x0)
		ptr null; uint8_t* java_map (0x0)
	}, ; 0
	%struct.TypeMapModule {
		[16 x i8] c"\C68;]\EC\D6nE\A9\D7%\FE\1D[11", ; module_uuid: 5d3b38c6-d6ec-456e-a9d7-25fe1d5b3131
		i32 43, ; uint32_t entry_count (0x2b)
		i32 12, ; uint32_t duplicate_count (0xc)
		ptr @module1_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module1_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.1_assembly_name, ; assembly_name: Mono.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width (0x0)
		ptr null; uint8_t* java_map (0x0)
	} ; 1
], align 8

; Java types name hashes
@map_java_hashes = dso_local local_unnamed_addr constant [44 x i64] [
	i64 128182020419974451, ; 0: 0x1c764de51b97533 => java/lang/String
	i64 361870449891484378, ; 1: 0x5059f41c47e22da => android/os/Bundle
	i64 870874870088288028, ; 2: 0xc15f8148b6d471c => java/lang/Exception
	i64 1317579852464953526, ; 3: 0x1248fbe51d6298b6 => java/io/FileInputStream
	i64 1320822650197077237, ; 4: 0x12548133cc496cf5 => android/runtime/JavaProxyThrowable
	i64 1747499027921055994, ; 5: 0x18405d1b749330fa => android/os/BaseBundle
	i64 1831728799718484971, ; 6: 0x196b9ba37012abeb => java/io/IOException
	i64 2164140653916027403, ; 7: 0x1e08927568a57a0b => java/io/InputStream
	i64 2270205244544766606, ; 8: 0x1f8163a45051d28e => android/view/SurfaceHolder
	i64 2375243497726607572, ; 9: 0x20f68f60690d00d4 => java/lang/System
	i64 2542726837267699812, ; 10: 0x2349949628319864 => android/view/Window
	i64 3476617847597562063, ; 11: 0x303f6d8331d5f8cf => java/io/PrintWriter
	i64 3852049679258842853, ; 12: 0x35753ac6356176e5 => android/view/SurfaceHolder$Callback
	i64 3940353796168302121, ; 13: 0x36aef2e695f93e29 => android/graphics/Canvas
	i64 4305371449952891808, ; 14: 0x3bbfc085dc8cf3a0 => java/lang/Class
	i64 5214467817578676657, ; 15: 0x485d82da477bc1b1 => java/lang/Error
	i64 6483641438813611034, ; 16: 0x59fa85896b7ce41a => crc64729e8e3dcb3f2cdf/MainActivity
	i64 6887549445287282166, ; 17: 0x5f957dba8b4985f6 => android/view/Surface
	i64 8190305621607579207, ; 18: 0x71a9cf9199cdfe47 => java/nio/channels/spi/AbstractInterruptibleChannel
	i64 8487642170263250902, ; 19: 0x75ca29959b2aa7d6 => android/content/ContextWrapper
	i64 8587172038193766563, ; 20: 0x772bc378d1b4e0a3 => java/lang/Runnable
	i64 9667515047141612341, ; 21: 0x8629e9b6f59e9b35 => java/lang/Thread
	i64 9869939015140501507, ; 22: 0x88f9113db837e803 => android/app/Activity
	i64 11112718717483603117, ; 23: 0x9a384ecbbc71d4ad => android/os/Handler
	i64 11573301743732151818, ; 24: 0xa09ca09e3190560a => mono/java/lang/RunnableImplementor
	i64 11954228872253987625, ; 25: 0xa5e5f3d2b66adb29 => android/view/View
	i64 12228984007958404582, ; 26: 0xa9b61429ce4b1de6 => android/content/Context
	i64 12476375190645835422, ; 27: 0xad24fd221af1069e => android/os/Looper
	i64 13252491226311317086, ; 28: 0xb7ea4e8e3d44565e => android/view/SurfaceHolder$Callback2
	i64 13402779434266666368, ; 29: 0xba003ce26e602580 => mono/android/TypeManager
	i64 13493236796125990997, ; 30: 0xbb419b603751d055 => android/graphics/Rect
	i64 13770727111868296170, ; 31: 0xbf1b735909c02bea => java/io/StringWriter
	i64 13805562342397192842, ; 32: 0xbf9735ce2f182a8a => android/util/AttributeSet
	i64 14008091590880237307, ; 33: 0xc266bd15778d96fb => android/os/Process
	i64 14031640676547298208, ; 34: 0xc2ba66da3d8603a0 => java/nio/channels/FileChannel
	i64 14167891754637755728, ; 35: 0xc49e767c735e8550 => java/lang/Object
	i64 14206023932851353817, ; 36: 0xc525ef800c4d78d9 => mono/android/runtime/OutputStreamAdapter
	i64 14940408132235664607, ; 37: 0xcf56fe09e1439cdf => java/lang/Throwable
	i64 15142650489578038267, ; 38: 0xd22580641d31a3fb => java/lang/StackTraceElement
	i64 15633873768898914415, ; 39: 0xd8f6ad5c6a84686f => java/io/Writer
	i64 16314168557433322311, ; 40: 0xe26791dde7a8fb47 => android/view/ContextThemeWrapper
	i64 16542847110558016359, ; 41: 0xe593ffcc9e686367 => android/app/Application
	i64 16723123314454325679, ; 42: 0xe814780d351a69af => mono/android/runtime/InputStreamAdapter
	i64 17125416866214736517 ; 43: 0xeda9b3e7cd367285 => java/io/OutputStream
], align 8

@module0_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 33554437, ; uint32_t type_token_id (0x2000005)
		i32 16; uint32_t java_map_index (0x10)
	} ; 0
], align 4

@module1_managed_to_java = internal dso_local constant [43 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 33554488, ; uint32_t type_token_id (0x2000038)
		i32 32; uint32_t java_map_index (0x20)
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 33554490, ; uint32_t type_token_id (0x200003a)
		i32 5; uint32_t java_map_index (0x5)
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 33554491, ; uint32_t type_token_id (0x200003b)
		i32 1; uint32_t java_map_index (0x1)
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 33554492, ; uint32_t type_token_id (0x200003c)
		i32 23; uint32_t java_map_index (0x17)
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 33554493, ; uint32_t type_token_id (0x200003d)
		i32 27; uint32_t java_map_index (0x1b)
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 33554494, ; uint32_t type_token_id (0x200003e)
		i32 33; uint32_t java_map_index (0x21)
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 33554496, ; uint32_t type_token_id (0x2000040)
		i32 22; uint32_t java_map_index (0x16)
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 33554497, ; uint32_t type_token_id (0x2000041)
		i32 41; uint32_t java_map_index (0x29)
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 33554501, ; uint32_t type_token_id (0x2000045)
		i32 40; uint32_t java_map_index (0x28)
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 33554502, ; uint32_t type_token_id (0x2000046)
		i32 12; uint32_t java_map_index (0xc)
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 33554504, ; uint32_t type_token_id (0x2000048)
		i32 28; uint32_t java_map_index (0x1c)
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 33554506, ; uint32_t type_token_id (0x200004a)
		i32 8; uint32_t java_map_index (0x8)
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 33554508, ; uint32_t type_token_id (0x200004c)
		i32 17; uint32_t java_map_index (0x11)
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 33554509, ; uint32_t type_token_id (0x200004d)
		i32 25; uint32_t java_map_index (0x19)
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 33554510, ; uint32_t type_token_id (0x200004e)
		i32 10; uint32_t java_map_index (0xa)
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 33554532, ; uint32_t type_token_id (0x2000064)
		i32 42; uint32_t java_map_index (0x2a)
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 33554534, ; uint32_t type_token_id (0x2000066)
		i32 4; uint32_t java_map_index (0x4)
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 33554545, ; uint32_t type_token_id (0x2000071)
		i32 36; uint32_t java_map_index (0x24)
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 33554551, ; uint32_t type_token_id (0x2000077)
		i32 13; uint32_t java_map_index (0xd)
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 33554552, ; uint32_t type_token_id (0x2000078)
		i32 30; uint32_t java_map_index (0x1e)
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 33554554, ; uint32_t type_token_id (0x200007a)
		i32 26; uint32_t java_map_index (0x1a)
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 33554556, ; uint32_t type_token_id (0x200007c)
		i32 19; uint32_t java_map_index (0x13)
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 33554557, ; uint32_t type_token_id (0x200007d)
		i32 34; uint32_t java_map_index (0x22)
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 33554559, ; uint32_t type_token_id (0x200007f)
		i32 18; uint32_t java_map_index (0x12)
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 33554561, ; uint32_t type_token_id (0x2000081)
		i32 3; uint32_t java_map_index (0x3)
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 33554562, ; uint32_t type_token_id (0x2000082)
		i32 7; uint32_t java_map_index (0x7)
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 33554564, ; uint32_t type_token_id (0x2000084)
		i32 6; uint32_t java_map_index (0x6)
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 33554565, ; uint32_t type_token_id (0x2000085)
		i32 43; uint32_t java_map_index (0x2b)
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 33554567, ; uint32_t type_token_id (0x2000087)
		i32 11; uint32_t java_map_index (0xb)
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 33554568, ; uint32_t type_token_id (0x2000088)
		i32 31; uint32_t java_map_index (0x1f)
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 33554569, ; uint32_t type_token_id (0x2000089)
		i32 39; uint32_t java_map_index (0x27)
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 33554571, ; uint32_t type_token_id (0x200008b)
		i32 14; uint32_t java_map_index (0xe)
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 33554572, ; uint32_t type_token_id (0x200008c)
		i32 15; uint32_t java_map_index (0xf)
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 33554573, ; uint32_t type_token_id (0x200008d)
		i32 2; uint32_t java_map_index (0x2)
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 33554574, ; uint32_t type_token_id (0x200008e)
		i32 20; uint32_t java_map_index (0x14)
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 33554576, ; uint32_t type_token_id (0x2000090)
		i32 9; uint32_t java_map_index (0x9)
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 33554577, ; uint32_t type_token_id (0x2000091)
		i32 35; uint32_t java_map_index (0x23)
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 33554578, ; uint32_t type_token_id (0x2000092)
		i32 38; uint32_t java_map_index (0x26)
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 33554579, ; uint32_t type_token_id (0x2000093)
		i32 0; uint32_t java_map_index (0x0)
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 33554581, ; uint32_t type_token_id (0x2000095)
		i32 21; uint32_t java_map_index (0x15)
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 33554582, ; uint32_t type_token_id (0x2000096)
		i32 24; uint32_t java_map_index (0x18)
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 33554583, ; uint32_t type_token_id (0x2000097)
		i32 37; uint32_t java_map_index (0x25)
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 33554594, ; uint32_t type_token_id (0x20000a2)
		i32 29; uint32_t java_map_index (0x1d)
	} ; 42
], align 4

@module1_managed_to_java_duplicates = internal dso_local constant [12 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 33554489, ; uint32_t type_token_id (0x2000039)
		i32 32; uint32_t java_map_index (0x20)
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 33554503, ; uint32_t type_token_id (0x2000047)
		i32 12; uint32_t java_map_index (0xc)
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 33554505, ; uint32_t type_token_id (0x2000049)
		i32 28; uint32_t java_map_index (0x1c)
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 33554507, ; uint32_t type_token_id (0x200004b)
		i32 8; uint32_t java_map_index (0x8)
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 33554511, ; uint32_t type_token_id (0x200004f)
		i32 10; uint32_t java_map_index (0xa)
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 33554555, ; uint32_t type_token_id (0x200007b)
		i32 26; uint32_t java_map_index (0x1a)
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 33554558, ; uint32_t type_token_id (0x200007e)
		i32 34; uint32_t java_map_index (0x22)
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 33554560, ; uint32_t type_token_id (0x2000080)
		i32 18; uint32_t java_map_index (0x12)
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 33554563, ; uint32_t type_token_id (0x2000083)
		i32 7; uint32_t java_map_index (0x7)
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 33554566, ; uint32_t type_token_id (0x2000086)
		i32 43; uint32_t java_map_index (0x2b)
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 33554570, ; uint32_t type_token_id (0x200008a)
		i32 39; uint32_t java_map_index (0x27)
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 33554575, ; uint32_t type_token_id (0x200008f)
		i32 20; uint32_t java_map_index (0x14)
	} ; 11
], align 4

; Java to managed map
@map_java = dso_local local_unnamed_addr constant [44 x %struct.TypeMapJava] [
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554579, ; uint32_t type_token_id (0x2000093)
		i32 39; uint32_t java_name_index (0x27)
	}, ; 0
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554491, ; uint32_t type_token_id (0x200003b)
		i32 3; uint32_t java_name_index (0x3)
	}, ; 1
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554573, ; uint32_t type_token_id (0x200008d)
		i32 34; uint32_t java_name_index (0x22)
	}, ; 2
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554561, ; uint32_t type_token_id (0x2000081)
		i32 25; uint32_t java_name_index (0x19)
	}, ; 3
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554534, ; uint32_t type_token_id (0x2000066)
		i32 17; uint32_t java_name_index (0x11)
	}, ; 4
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554490, ; uint32_t type_token_id (0x200003a)
		i32 2; uint32_t java_name_index (0x2)
	}, ; 5
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554564, ; uint32_t type_token_id (0x2000084)
		i32 27; uint32_t java_name_index (0x1b)
	}, ; 6
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554562, ; uint32_t type_token_id (0x2000082)
		i32 26; uint32_t java_name_index (0x1a)
	}, ; 7
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 0, ; uint32_t type_token_id (0x0)
		i32 12; uint32_t java_name_index (0xc)
	}, ; 8
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554576, ; uint32_t type_token_id (0x2000090)
		i32 36; uint32_t java_name_index (0x24)
	}, ; 9
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554510, ; uint32_t type_token_id (0x200004e)
		i32 15; uint32_t java_name_index (0xf)
	}, ; 10
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554567, ; uint32_t type_token_id (0x2000087)
		i32 29; uint32_t java_name_index (0x1d)
	}, ; 11
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 0, ; uint32_t type_token_id (0x0)
		i32 10; uint32_t java_name_index (0xa)
	}, ; 12
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554551, ; uint32_t type_token_id (0x2000077)
		i32 19; uint32_t java_name_index (0x13)
	}, ; 13
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554571, ; uint32_t type_token_id (0x200008b)
		i32 32; uint32_t java_name_index (0x20)
	}, ; 14
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554572, ; uint32_t type_token_id (0x200008c)
		i32 33; uint32_t java_name_index (0x21)
	}, ; 15
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index (0x0)
		i32 33554437, ; uint32_t type_token_id (0x2000005)
		i32 0; uint32_t java_name_index (0x0)
	}, ; 16
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554508, ; uint32_t type_token_id (0x200004c)
		i32 13; uint32_t java_name_index (0xd)
	}, ; 17
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554559, ; uint32_t type_token_id (0x200007f)
		i32 24; uint32_t java_name_index (0x18)
	}, ; 18
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554556, ; uint32_t type_token_id (0x200007c)
		i32 22; uint32_t java_name_index (0x16)
	}, ; 19
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 0, ; uint32_t type_token_id (0x0)
		i32 35; uint32_t java_name_index (0x23)
	}, ; 20
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554581, ; uint32_t type_token_id (0x2000095)
		i32 40; uint32_t java_name_index (0x28)
	}, ; 21
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554496, ; uint32_t type_token_id (0x2000040)
		i32 7; uint32_t java_name_index (0x7)
	}, ; 22
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554492, ; uint32_t type_token_id (0x200003c)
		i32 4; uint32_t java_name_index (0x4)
	}, ; 23
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554582, ; uint32_t type_token_id (0x2000096)
		i32 41; uint32_t java_name_index (0x29)
	}, ; 24
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554509, ; uint32_t type_token_id (0x200004d)
		i32 14; uint32_t java_name_index (0xe)
	}, ; 25
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554554, ; uint32_t type_token_id (0x200007a)
		i32 21; uint32_t java_name_index (0x15)
	}, ; 26
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554493, ; uint32_t type_token_id (0x200003d)
		i32 5; uint32_t java_name_index (0x5)
	}, ; 27
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 0, ; uint32_t type_token_id (0x0)
		i32 11; uint32_t java_name_index (0xb)
	}, ; 28
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554594, ; uint32_t type_token_id (0x20000a2)
		i32 43; uint32_t java_name_index (0x2b)
	}, ; 29
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554552, ; uint32_t type_token_id (0x2000078)
		i32 20; uint32_t java_name_index (0x14)
	}, ; 30
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554568, ; uint32_t type_token_id (0x2000088)
		i32 30; uint32_t java_name_index (0x1e)
	}, ; 31
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 0, ; uint32_t type_token_id (0x0)
		i32 1; uint32_t java_name_index (0x1)
	}, ; 32
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554494, ; uint32_t type_token_id (0x200003e)
		i32 6; uint32_t java_name_index (0x6)
	}, ; 33
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554557, ; uint32_t type_token_id (0x200007d)
		i32 23; uint32_t java_name_index (0x17)
	}, ; 34
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554577, ; uint32_t type_token_id (0x2000091)
		i32 37; uint32_t java_name_index (0x25)
	}, ; 35
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554545, ; uint32_t type_token_id (0x2000071)
		i32 18; uint32_t java_name_index (0x12)
	}, ; 36
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554583, ; uint32_t type_token_id (0x2000097)
		i32 42; uint32_t java_name_index (0x2a)
	}, ; 37
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554578, ; uint32_t type_token_id (0x2000092)
		i32 38; uint32_t java_name_index (0x26)
	}, ; 38
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554569, ; uint32_t type_token_id (0x2000089)
		i32 31; uint32_t java_name_index (0x1f)
	}, ; 39
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554501, ; uint32_t type_token_id (0x2000045)
		i32 9; uint32_t java_name_index (0x9)
	}, ; 40
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554497, ; uint32_t type_token_id (0x2000041)
		i32 8; uint32_t java_name_index (0x8)
	}, ; 41
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554532, ; uint32_t type_token_id (0x2000064)
		i32 16; uint32_t java_name_index (0x10)
	}, ; 42
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index (0x1)
		i32 33554565, ; uint32_t type_token_id (0x2000085)
		i32 28; uint32_t java_name_index (0x1c)
	} ; 43
], align 4

; Java type names
@java_type_names = dso_local local_unnamed_addr constant [44 x ptr] [
	ptr @.str.0, ; 0
	ptr @.str.1, ; 1
	ptr @.str.2, ; 2
	ptr @.str.3, ; 3
	ptr @.str.4, ; 4
	ptr @.str.5, ; 5
	ptr @.str.6, ; 6
	ptr @.str.7, ; 7
	ptr @.str.8, ; 8
	ptr @.str.9, ; 9
	ptr @.str.10, ; 10
	ptr @.str.11, ; 11
	ptr @.str.12, ; 12
	ptr @.str.13, ; 13
	ptr @.str.14, ; 14
	ptr @.str.15, ; 15
	ptr @.str.16, ; 16
	ptr @.str.17, ; 17
	ptr @.str.18, ; 18
	ptr @.str.19, ; 19
	ptr @.str.20, ; 20
	ptr @.str.21, ; 21
	ptr @.str.22, ; 22
	ptr @.str.23, ; 23
	ptr @.str.24, ; 24
	ptr @.str.25, ; 25
	ptr @.str.26, ; 26
	ptr @.str.27, ; 27
	ptr @.str.28, ; 28
	ptr @.str.29, ; 29
	ptr @.str.30, ; 30
	ptr @.str.31, ; 31
	ptr @.str.32, ; 32
	ptr @.str.33, ; 33
	ptr @.str.34, ; 34
	ptr @.str.35, ; 35
	ptr @.str.36, ; 36
	ptr @.str.37, ; 37
	ptr @.str.38, ; 38
	ptr @.str.39, ; 39
	ptr @.str.40, ; 40
	ptr @.str.41, ; 41
	ptr @.str.42, ; 42
	ptr @.str.43 ; 43
], align 8

; Strings
@.str.0 = private unnamed_addr constant [35 x i8] c"crc64729e8e3dcb3f2cdf/MainActivity\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"android/util/AttributeSet\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"android/os/BaseBundle\00", align 1
@.str.3 = private unnamed_addr constant [18 x i8] c"android/os/Bundle\00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c"android/os/Handler\00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"android/os/Looper\00", align 1
@.str.6 = private unnamed_addr constant [19 x i8] c"android/os/Process\00", align 1
@.str.7 = private unnamed_addr constant [21 x i8] c"android/app/Activity\00", align 1
@.str.8 = private unnamed_addr constant [24 x i8] c"android/app/Application\00", align 1
@.str.9 = private unnamed_addr constant [33 x i8] c"android/view/ContextThemeWrapper\00", align 1
@.str.10 = private unnamed_addr constant [36 x i8] c"android/view/SurfaceHolder$Callback\00", align 1
@.str.11 = private unnamed_addr constant [37 x i8] c"android/view/SurfaceHolder$Callback2\00", align 1
@.str.12 = private unnamed_addr constant [27 x i8] c"android/view/SurfaceHolder\00", align 1
@.str.13 = private unnamed_addr constant [21 x i8] c"android/view/Surface\00", align 1
@.str.14 = private unnamed_addr constant [18 x i8] c"android/view/View\00", align 1
@.str.15 = private unnamed_addr constant [20 x i8] c"android/view/Window\00", align 1
@.str.16 = private unnamed_addr constant [40 x i8] c"mono/android/runtime/InputStreamAdapter\00", align 1
@.str.17 = private unnamed_addr constant [35 x i8] c"android/runtime/JavaProxyThrowable\00", align 1
@.str.18 = private unnamed_addr constant [41 x i8] c"mono/android/runtime/OutputStreamAdapter\00", align 1
@.str.19 = private unnamed_addr constant [24 x i8] c"android/graphics/Canvas\00", align 1
@.str.20 = private unnamed_addr constant [22 x i8] c"android/graphics/Rect\00", align 1
@.str.21 = private unnamed_addr constant [24 x i8] c"android/content/Context\00", align 1
@.str.22 = private unnamed_addr constant [31 x i8] c"android/content/ContextWrapper\00", align 1
@.str.23 = private unnamed_addr constant [30 x i8] c"java/nio/channels/FileChannel\00", align 1
@.str.24 = private unnamed_addr constant [51 x i8] c"java/nio/channels/spi/AbstractInterruptibleChannel\00", align 1
@.str.25 = private unnamed_addr constant [24 x i8] c"java/io/FileInputStream\00", align 1
@.str.26 = private unnamed_addr constant [20 x i8] c"java/io/InputStream\00", align 1
@.str.27 = private unnamed_addr constant [20 x i8] c"java/io/IOException\00", align 1
@.str.28 = private unnamed_addr constant [21 x i8] c"java/io/OutputStream\00", align 1
@.str.29 = private unnamed_addr constant [20 x i8] c"java/io/PrintWriter\00", align 1
@.str.30 = private unnamed_addr constant [21 x i8] c"java/io/StringWriter\00", align 1
@.str.31 = private unnamed_addr constant [15 x i8] c"java/io/Writer\00", align 1
@.str.32 = private unnamed_addr constant [16 x i8] c"java/lang/Class\00", align 1
@.str.33 = private unnamed_addr constant [16 x i8] c"java/lang/Error\00", align 1
@.str.34 = private unnamed_addr constant [20 x i8] c"java/lang/Exception\00", align 1
@.str.35 = private unnamed_addr constant [19 x i8] c"java/lang/Runnable\00", align 1
@.str.36 = private unnamed_addr constant [17 x i8] c"java/lang/System\00", align 1
@.str.37 = private unnamed_addr constant [17 x i8] c"java/lang/Object\00", align 1
@.str.38 = private unnamed_addr constant [28 x i8] c"java/lang/StackTraceElement\00", align 1
@.str.39 = private unnamed_addr constant [17 x i8] c"java/lang/String\00", align 1
@.str.40 = private unnamed_addr constant [17 x i8] c"java/lang/Thread\00", align 1
@.str.41 = private unnamed_addr constant [35 x i8] c"mono/java/lang/RunnableImplementor\00", align 1
@.str.42 = private unnamed_addr constant [20 x i8] c"java/lang/Throwable\00", align 1
@.str.43 = private unnamed_addr constant [25 x i8] c"mono/android/TypeManager\00", align 1

;TypeMapModule
@.TypeMapModule.0_assembly_name = private unnamed_addr constant [21 x i8] c"StereoKitInk_Android\00", align 1
@.TypeMapModule.1_assembly_name = private unnamed_addr constant [13 x i8] c"Mono.Android\00", align 1

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.1xx @ f1b7113872c8db3dfee70d11925e81bb752dc8d0"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
