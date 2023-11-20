; ModuleID = 'marshal_methods.arm64-v8a.ll'
source_filename = "marshal_methods.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [15 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [30 x i64] [
	i64 120698629574877762, ; 0: Mono.Android => 0x1accec39cafe242 => 14
	i64 750875890346172408, ; 1: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 9
	i64 1513467482682125403, ; 2: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 13
	i64 1537168428375924959, ; 3: System.Threading.Thread.dll => 0x15551e8a954ae0df => 9
	i64 2497223385847772520, ; 4: System.Runtime => 0x22a7eb7046413568 => 8
	i64 3311221304742556517, ; 5: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 6
	i64 3551103847008531295, ; 6: System.Private.CoreLib.dll => 0x31480e226177735f => 11
	i64 3571415421602489686, ; 7: System.Runtime.dll => 0x319037675df7e556 => 8
	i64 3716579019761409177, ; 8: netstandard.dll => 0x3393f0ed5c8c5c99 => 10
	i64 5392046066271750854, ; 9: StereoKitInk_Android.dll => 0x4ad4655438ab8ac6 => 2
	i64 6357457916754632952, ; 10: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 0
	i64 6894844156784520562, ; 11: System.Numerics.Vectors => 0x5faf683aead1ad72 => 6
	i64 7270811800166795866, ; 12: System.Linq => 0x64e71ccf51a90a5a => 5
	i64 7644476970092902111, ; 13: StereoKitInk_Android => 0x6a16a34d580ab6df => 2
	i64 7714652370974252055, ; 14: System.Private.CoreLib => 0x6b0ff375198b9c17 => 11
	i64 8064050204834738623, ; 15: System.Collections.dll => 0x6fe942efa61731bf => 3
	i64 8167236081217502503, ; 16: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 12
	i64 8185542183669246576, ; 17: System.Collections => 0x7198e33f4794aa70 => 3
	i64 8626175481042262068, ; 18: Java.Interop => 0x77b654e585b55834 => 12
	i64 9808709177481450983, ; 19: Mono.Android.dll => 0x881f890734e555e7 => 14
	i64 11485890710487134646, ; 20: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 7
	i64 11597940890313164233, ; 21: netstandard => 0xa0f429ca8d1805c9 => 10
	i64 12475113361194491050, ; 22: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 0
	i64 13029669184510158566, ; 23: StereoKit.dll => 0xb4d2af16d394e6e6 => 1
	i64 13343850469010654401, ; 24: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 13
	i64 13881769479078963060, ; 25: System.Console.dll => 0xc0a5f3cade5c6774 => 4
	i64 14978342719919667747, ; 26: StereoKit => 0xcfddc35858deba23 => 1
	i64 15133485256822086103, ; 27: System.Linq.dll => 0xd204f0a9127dd9d7 => 5
	i64 15527772828719725935, ; 28: System.Console => 0xd77dbb1e38cd3d6f => 4
	i64 17712670374920797664 ; 29: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 7
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [30 x i32] [
	i32 14, ; 0
	i32 9, ; 1
	i32 13, ; 2
	i32 9, ; 3
	i32 8, ; 4
	i32 6, ; 5
	i32 11, ; 6
	i32 8, ; 7
	i32 10, ; 8
	i32 2, ; 9
	i32 0, ; 10
	i32 6, ; 11
	i32 5, ; 12
	i32 2, ; 13
	i32 11, ; 14
	i32 3, ; 15
	i32 12, ; 16
	i32 3, ; 17
	i32 12, ; 18
	i32 14, ; 19
	i32 7, ; 20
	i32 10, ; 21
	i32 0, ; 22
	i32 1, ; 23
	i32 13, ; 24
	i32 4, ; 25
	i32 1, ; 26
	i32 5, ; 27
	i32 4, ; 28
	i32 7 ; 29
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" }

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
