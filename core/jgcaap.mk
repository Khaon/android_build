#Most of the ideas are from Archi I just used his organization to be easier to try out new flags as also his on. All this flag optimization come from his idea. where you can find more at: https://github.com/ArchiDroid/android_build/commit/a062cc61184950df02c39a038c5bfaef5a8b268c
# General optimization level of target ARM compiled with GCC. Default: -O2
NEW_GCC_CFLAGS_ARM := -O2 -march=armv7-a -mfpu=neon-vfpv4

# General optimization level of target THUMB compiled with GCC. Default: -Os
NEW_GCC_CFLAGS_THUMB := -O2 -DNDEBUG -march=armv7-a

# Additional flags passed to all C targets compiled with GCC
NEW_GCC_CFLAGS := $(ALIGNED) -DNDEBUG

ALIGNED = -O2 -Wno-invalid-command-line-argument -Wno-unused-command-line-argument -march=armv7-a
#-floop-flatten -floop-parallelize-all -ftree-loop-linear -floop-interchange -floop-strip-mine -floop-block -fgcse-las -ftree-slp-vectorize -ffunction-sections  -funwind-tables -fstack-protector -ftree-vectorize -fpredictive-commoning -fgcse-las -fgcse-lm -fgcse-sm -fsched-spec-load -Wno-invalid-command-line-argument -Wno-unused-command-line-argument

# Flags passed to all C targets compiled with GCC
NEW_GCC_CPPFLAGS := $(NEW_GCC_CFLAGS)

# Flags passed to linker (ld) of all C and C targets compiled with GCC
NEW_GCC_LDFLAGS := -Wl,--sort-common


# CLANG

# Flags passed to all C targets compiled with CLANG
NEW_CLANG_CFLAGS := $(ALIGNED) -Qunused-arguments -Wno-unknown-warning-option \
# Flags passed to all C targets compiled with CLANG
NEW_CLANG_CPPFLAGS := $(NEW_CLANG_CFLAGS)

# Flags passed to linker (ld) of all C and C targets compiled with CLANG
NEW_CLANG_LDFLAGS := -Wl,--sort-common

# Flags that are used by GCC, but are unknown to CLANG. If you get "argument unused during compilation" error, add the flag here
NEW_CLANG_UNKNOWN_FLAGS := \
  -mvectorize-with-neon-double \
  -mvectorize-with-neon-quad \
  -fgcse-after-reload \
  -fgcse-las \
  -fgcse-sm \
  -fgraphite \
  -fgraphite-identity \
  -fipa-pta \
  -floop-block \
  -floop-interchange \
  -floop-nest-optimize \
  -floop-parallelize-all \
  -ftree-parallelize-loops=2 \
  -ftree-parallelize-loops=4 \
  -ftree-parallelize-loops=8 \
  -ftree-parallelize-loops=16 \
  -floop-strip-mine \
  -fmodulo-sched \
  -fmodulo-sched-allow-regmoves \
  -frerun-cse-after-loop \
  -frename-registers \
  -fsection-anchors \
  -ftree-loop-im \
  -ftree-loop-ivcanon \
  -funsafe-loop-optimizations \
  -fweb \
  -fno-omit-frame-pointer \
  -fpic


##########################
#  FLOOP_NEST_OPTIMIZE   #
########################## 
LOCAL_ENABLE_NEST := \
    art \
    libsigchain \
    libart \
    libart-compiler \
    libartd \
    libartd-compiler \
    libart-disassembler \
    libartd-disassembler \
    core.art-host \
    core.art \
    cpplint-art-phony \
    libnativebridgetest \
    libarttest \
    art-run-tests \
    libart-gtest \
    libc \
    libc_gdtoa \
    libc_netbsd \
    libc_freebsd \
    libc_openbsd \
    libc_cxa \
    libc_syscalls \
    libc_aeabi \
    libc_common \
    libc_nomalloc \
    libc_malloc \
    libc_stack_protector \
    libc_tzcode \
    libstdc++ \
    linker \
    libdl \
    libm \
    tzdata \
    bionic-benchmarks
#############################
#  END FLOOP_NEST_OPTIMIZE  #
#############################

# TARGET_USE_PIPE
LOCAL_DISABLE_PIPE := \
	libc_dns \
	libc_tzcode \
        bluetooth \
	bluetooth.default

ifneq (1,$(words $(filter $(LOCAL_DISABLE_PIPE), $(LOCAL_MODULE))))
ifdef LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += \
	-pipe
else
LOCAL_CONLYFLAGS := \
	-pipe
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += \
	-pipe
else
LOCAL_CPPFLAGS := \
	-pipe
endif
endif
#####

########################
#     ENABLE_GCCONLY   #
########################
LOCAL_DISABLE_GCCONLY := \
    bluetooth.default \
    libwebviewchromium \
    libwebviewchromium_loader \
    libwebviewchromium_plat_support

GCC_ONLY := \
    -fira-loop-pressure \
    -fforce-addr \
    -funsafe-loop-optimizations \
    -funroll-loops \
    -ftree-loop-distribution \
    -fsection-anchors \
    -ftree-loop-im \
    -ftree-loop-ivcanon \
    -ffunction-sections \
    -fgcse-las \
    -fgcse-sm \
    -fweb \
    -ffp-contract=fast \
    -mvectorize-with-neon-quad
#########################
#     END GCC ONLY      #
#########################

#########################
#    KRAIT_TUNINGS      #
#########################
LOCAL_DISABLE_KRAIT := \
    libc_dns \
    libc_tzcode \
    bluetooth.default \
    libwebviewchromium \
    libwebviewchromium_loader \
    libwebviewchromium_plat_support \
    libbluetooth_jni \
    libbt-brcm_stack \
    audio.a2dp.default \
    libbt-brcm_bta \
    bt_stack.conf \
    libbt-brcm_bta \
    libbt-brcm_gki \
    libbt-brcm_stack \
    libbt-hci \
    libbt-utils \
    libosi \
    libtinyxml2 \
    libbt-qcom_sbc_decoder \
    android.bluetooth.client.map \
    bt_did.conf \
    auto_pair_devlist.conf

KRAIT_FLAGS := \
    -mcpu=cortex-a15 \
    -mtune=cortex-a15 

#####################
# STRICT_ALIASING   #
#####################
LOCAL_DISABLE_STRICT := \
    third_party_libyuv_libyuv_gyp \
    third_party_WebKit_Source_wtf_wtf_gyp \
    ipc_ipc_gyp \
    third_party_webrtc_base_rtc_base_gyp \
    courgette_courgette_lib_gyp \
    third_party_WebKit_Source_platform_blink_common_gyp \
    cc_cc_surfaces_gyp \
    net_http_server_gyp \
    base_base_gyp \
    ui_gfx_gfx_gyp \
    android_webview_native_webview_native_gyp \
    jingle_jingle_glue_gyp \
    ui_native_theme_native_theme_gyp \
    third_party_WebKit_Source_core_webcore_dom_gyp \
    third_party_WebKit_Source_core_webcore_html_gyp \
    third_party_WebKit_Source_core_webcore_rendering_gyp \
    third_party_WebKit_Source_core_webcore_svg_gyp \
    components_autofill_content_browser_gyp \
    ui_surface_surface_gyp \
    printing_printing_gyp \
    third_party_WebKit_Source_web_blink_web_gyp \
    third_party_webrtc_modules_media_file_gyp \
    cc_cc_gyp \
    storage_storage_gyp \
    android_webview_android_webview_common_gyp \
    content_content_browser_gyp \
    content_content_common_gyp \
    content_content_child_gyp \
    third_party_webrtc_modules_webrtc_utility_gyp \
    third_party_webrtc_modules_iLBC_gyp \
    third_party_webrtc_modules_neteq_gyp \
    third_party_webrtc_modules_audio_device_gyp\
    third_party_webrtc_modules_rtp_rtcp_gyp \
    components_data_reduction_proxy_browser_gyp \
    libunwind \
    libc_malloc \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.exfat \
    fsck.exfat \
    mount.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    libc_dns \
    libc_tzcode \
    libtwrpmtp \
    libfusetwrp \
    libguitwrp \
    busybox \
    toolbox \
    clatd \
    ip \
    libuclibcrpc \
    libpdfiumcore \
    libpdfiumcore \
    libpdfium \
    bluetooth.default \
    logd \
    mdnsd \
    libfuse \
    libcutils \
    liblog \
    healthd \
    adbd \
    libunwind \
    libsync \
    libnetutils \
    libusbhost \
    libfs_mgr \
    libvold \
    net_net_gyp \
    libstagefright_webm \
    libaudioflinger \
    libmediaplayerservice \
    libstagefright_avcenc \
    libstagefright_avc_common \
    libstagefright_httplive \
    libstagefright_rtsp \
    sdcard \
    libnetlink \
    libfdlibm \
    libvariablespeed \
    librtp_jni \
    libwilhelm \
    debuggerd \
    libbt-brcm_bta \
    libbt-brcm_stack \
    libdownmix \
    libldnhncr \
    libqcomvisualizer \
    libvisualizer \
    libutils \
    static_busybox \
    libstagefright_foundation \
    content_content_renderer_gyp \
    third_party_WebKit_Source_modules_modules_gyp \
    third_party_WebKit_Source_platform_blink_platform_gyp \
    third_party_WebKit_Source_core_webcore_remaining_gyp \
    third_party_angle_src_translator_lib_gyp \
    third_party_WebKit_Source_core_webcore_generated_gyp \
    libc_gdtoa \
    libc_openbsd \
    libc \
    libc_nomalloc \
    patchoat \
    dex2oat \
    libart \
    libart-compiler \
    oatdump \
    libart-disassembler \
    mm-vdec-omx-test \
    libziparchive-host \
    libziparchive \
    libdiskconfig \
    logd \
    linker \
    libjavacore \
    camera.bacon \
    libmmcamera_interface \
    tcpdump

DISABLE_STRICT := \
    -fno-strict-aliasing

STRICT_ALIASING_FLAGS := \
    -fstrict-aliasing \
    -Werror=strict-aliasing

STRICT_GCC_LEVEL := \
    -Wstrict-aliasing=3

STRICT_CLANG_LEVEL := \
    -Wstrict-aliasing=2
#########################
#  END STRICT_ALIASING  #
#########################

####################
#      O3 FLAG     #
####################

LOCAL_DISABLE_O3 := \
	libstagefright \
	libstagefright_soft_aacdec \
	libstagefright_id3 \
	libbluetooth_jni \
	libbt-brcm_bta \
	libbt-brcm_stack \
	libbt-hci \
	libaudioflinger \
	libbinder \
	libexynosv4l2 \
	bluetooth.default \
	$(WEBCHROMIUM_STATIC_LIBRARIES) \
	libwebviewchromium \
	libwebviewchromium_loader \
	libwebviewchromium_plat_support

LOCAL_O3_EXTRAS_FLAGS := -fno-inline-functions

# Currently building with GCC 5.x yields to false positives errors
# This ensures the build is not hatled on the following errors
ifneq ($(filter $($(combo_2nd_arch_prefix)TARGET_GCC_VERSION), 5.1 5.1.%),)
    LOCAL_O3_EXTRAS_FLAGS += -Wno-array-bounds -Wno-strict-overflow
endif

ifeq ($(DISABLE_OPTIMIZATIONS_ON_CHROMIUM),true)
    LOCAL_DISABLE_O3 += $(WEBCHROMIUM_STATIC_LIBRARIES)
endif

ifeq ($(TARGET_DEVICE),bacon)
    LOCAL_O3_EXTRAS_FLAGS += -fno-tree-vectorize
endif

O3_FLAGS := -O3 $(LOCAL_O3_EXTRAS_FLAGS)
####################
#  END  03  FLAGS  #
####################

WEBCHROMIUM_STATIC_LIBRARIES := \
    android_webview_android_webview_common_gyp \
    android_webview_native_webview_native_gyp \
    base_base_static_gyp \
    base_third_party_dynamic_annotations_dynamic_annotations_gyp \
    cc_cc_gyp \
    base_base_gyp \
    base_allocator_allocator_extension_thunks_gyp \
    third_party_modp_b64_modp_b64_gyp \
    third_party_ashmem_ashmem_gyp \
    third_party_libevent_libevent_gyp \
    gpu_command_buffer_client_gyp \
    gpu_command_buffer_common_gyp \
    gpu_command_buffer_gles2_utils_gyp \
    gpu_command_buffer_service_gyp \
    gpu_disk_cache_proto_gyp \
    third_party_protobuf_protobuf_lite_gyp \
    crypto_crypto_gyp \
    third_party_boringssl_boringssl_gyp \
    third_party_re2_re2_gyp \
    third_party_smhasher_cityhash_gyp \
    ui_gfx_gfx_gyp \
    base_base_i18n_gyp \
    skia_skia_library_gyp \
    skia_skia_opts_gyp \
    skia_skia_opts_neon_gyp \
    third_party_zlib_zlib_gyp \
    third_party_sfntly_sfntly_gyp \
    third_party_expat_expat_gyp \
    third_party_freetype_ft2_gyp \
    third_party_libpng_libpng_gyp \
    skia_skia_chrome_gyp \
    skia_skia_chrome_opts_gyp \
    third_party_harfbuzz_ng_harfbuzz_ng_gyp \
    ui_gfx_gfx_geometry_gyp \
    third_party_libjpeg_turbo_libjpeg_gyp \
    ui_gl_gl_gyp \
    third_party_angle_src_translator_gyp \
    third_party_angle_src_translator_lib_gyp \
    third_party_angle_src_preprocessor_gyp \
    gpu_gles2_cmd_helper_gyp \
    gpu_gpu_config_gyp \
    gpu_gpu_ipc_gyp \
    ipc_ipc_gyp \
    media_media_gyp \
    third_party_libyuv_libyuv_gyp \
    third_party_libyuv_libyuv_neon_gyp \
    third_party_opus_opus_gyp \
    ui_events_events_base_gyp \
    ui_events_dom4_keycode_converter_gyp \
    url_url_lib_gyp \
    media_shared_memory_support_gyp \
    media_player_android_gyp \
    components_autofill_content_browser_gyp \
    base_base_prefs_gyp \
    content_content_browser_gyp \
    content_content_common_gyp \
    components_tracing_gyp \
    net_net_gyp \
    sdch_sdch_gyp \
    ui_accessibility_accessibility_gyp \
    ui_accessibility_ax_gen_gyp \
    tools_json_schema_compiler_api_gen_util_gyp \
    ui_base_ui_base_gyp \
    ui_events_events_gyp \
    ui_events_gesture_detection_gyp \
    ui_events_platform_events_platform_gyp \
    ui_events_ipc_events_ipc_gyp \
    ui_gfx_ipc_gfx_ipc_gyp \
    ui_shell_dialogs_shell_dialogs_gyp \
    gpu_gles2_c_lib_gyp \
    gpu_gles2_implementation_gyp \
    gpu_gl_in_process_context_gyp \
    gpu_skia_bindings_gpu_skia_bindings_gyp \
    ipc_mojo_ipc_mojo_gyp \
    mojo_mojo_cpp_bindings_gyp \
    mojo_mojo_environment_chromium_gyp \
    mojo_mojo_environment_chromium_impl_gyp \
    mojo_mojo_common_lib_gyp \
    mojo_mojo_system_impl_gyp \
    mojo_mojo_application_bindings_gyp \
    storage_storage_gyp \
    sql_sql_gyp \
    third_party_sqlite_sqlite_gyp \
    libft2 \
    storage_storage_common_gyp \
    third_party_leveldatabase_leveldatabase_gyp \
    third_party_WebKit_Source_platform_blink_platform_gyp \
    third_party_WebKit_Source_wtf_wtf_gyp \
    third_party_WebKit_Source_platform_blink_common_gyp \
    third_party_WebKit_Source_platform_blink_heap_asm_stubs_gyp \
    third_party_libwebp_libwebp_dec_gyp \
    third_party_libwebp_libwebp_dsp_gyp \
    third_party_libwebp_libwebp_dsp_neon_gyp \
    third_party_libwebp_libwebp_utils_gyp \
    third_party_libwebp_libwebp_demux_gyp \
    third_party_libwebp_libwebp_enc_gyp \
    third_party_ots_ots_gyp \
    third_party_brotli_brotli_gyp \
    third_party_qcms_qcms_gyp \
    v8_tools_gyp_v8_base_gyp \
    v8_tools_gyp_v8_libbase_gyp \
    v8_tools_gyp_v8_snapshot_gyp \
    third_party_iccjpeg_iccjpeg_gyp \
    third_party_openmax_dl_dl_openmax_dl_gyp \
    third_party_openmax_dl_dl_openmax_dl_armv7_gyp \
    third_party_WebKit_Source_platform_blink_arm_neon_gyp \
    third_party_WebKit_Source_web_blink_web_gyp \
    third_party_WebKit_Source_core_webcore_dom_gyp \
    third_party_libxml_libxml_gyp \
    third_party_libxslt_libxslt_gyp \
    third_party_WebKit_Source_core_webcore_html_gyp \
    third_party_WebKit_Source_core_webcore_remaining_gyp \
    third_party_WebKit_Source_core_webcore_rendering_gyp \
    third_party_WebKit_Source_core_webcore_svg_gyp \
    third_party_WebKit_Source_core_webcore_generated_gyp \
    gin_gin_gyp \
    third_party_WebKit_Source_modules_modules_gyp \
    webkit_common_gpu_webkit_gpu_gyp \
    third_party_libjingle_libjingle_gyp \
    third_party_webrtc_base_rtc_base_gyp \
    third_party_webrtc_base_rtc_base_approved_gyp \
    third_party_webrtc_libjingle_xmllite_rtc_xmllite_gyp \
    third_party_libjingle_libjingle_p2p_constants_gyp \
    google_apis_google_apis_gyp \
    third_party_zlib_google_zip_gyp \
    third_party_zlib_minizip_gyp \
    ui_snapshot_snapshot_gyp \
    content_browser_service_worker_proto_gyp \
    content_browser_speech_proto_speech_proto_gyp \
    content_content_child_gyp \
    content_content_gpu_gyp \
    content_content_utility_gyp \
    courgette_courgette_lib_gyp \
    third_party_lzma_sdk_lzma_sdk_gyp \
    content_content_common_mojo_bindings_gyp \
    cc_cc_surfaces_gyp \
    mojo_mojo_js_bindings_gyp \
    net_http_server_gyp \
    ui_surface_surface_gyp \
    printing_printing_gyp \
    sandbox_sandbox_services_gyp \
    sandbox_seccomp_bpf_gyp \
    sandbox_seccomp_bpf_helpers_gyp \
    jingle_jingle_glue_gyp \
    third_party_libphonenumber_libphonenumber_gyp \
    third_party_libphonenumber_libphonenumber_without_metadata_gyp \
    components_autofill_content_common_gyp \
    components_autofill_core_common_gyp \
    components_autofill_content_risk_proto_gyp \
    components_autofill_core_browser_gyp \
    third_party_fips181_fips181_gyp \
    third_party_libaddressinput_libaddressinput_util_gyp \
    components_keyed_service_core_gyp \
    components_os_crypt_gyp \
    components_pref_registry_gyp \
    components_webdata_common_gyp \
    components_user_prefs_gyp \
    components_web_contents_delegate_android_gyp \
    components_auto_login_parser_gyp \
    components_autofill_content_renderer_gyp \
    content_content_renderer_gyp \
    cc_blink_cc_blink_gyp \
    media_blink_media_blink_gyp \
    mojo_mojo_js_bindings_lib_gyp \
    ui_native_theme_native_theme_gyp \
    third_party_libjingle_libjingle_webrtc_gyp \
    third_party_libjingle_libjingle_webrtc_common_gyp \
    third_party_libsrtp_libsrtp_gyp \
    third_party_webrtc_modules_media_file_gyp \
    third_party_webrtc_system_wrappers_source_system_wrappers_gyp \
    third_party_webrtc_system_wrappers_source_cpu_features_android_gyp \
    third_party_webrtc_modules_video_capture_module_impl_gyp \
    third_party_webrtc_modules_video_capture_module_gyp \
    third_party_webrtc_modules_webrtc_utility_gyp \
    third_party_webrtc_modules_audio_coding_module_gyp \
    third_party_webrtc_modules_CNG_gyp \
    third_party_webrtc_common_audio_common_audio_gyp \
    third_party_webrtc_common_audio_common_audio_neon_gyp \
    third_party_webrtc_modules_G711_gyp \
    third_party_webrtc_modules_G722_gyp \
    third_party_webrtc_modules_iLBC_gyp \
    third_party_webrtc_modules_iSAC_gyp \
    third_party_webrtc_modules_iSACFix_gyp \
    third_party_webrtc_modules_isac_neon_gyp \
    third_party_webrtc_modules_PCM16B_gyp \
    third_party_webrtc_modules_webrtc_opus_gyp \
    third_party_webrtc_modules_neteq_gyp \
    third_party_webrtc_modules_webrtc_video_coding_gyp \
    third_party_webrtc_modules_webrtc_i420_gyp \
    third_party_webrtc_common_video_common_video_gyp \
    third_party_webrtc_modules_video_coding_utility_video_coding_utility_gyp \
    third_party_webrtc_modules_video_coding_codecs_vp8_webrtc_vp8_gyp \
    third_party_libvpx_libvpx_gyp \
    libvpx_asm_offsets_vp8 \
    libvpx_asm_offsets_vpx_scale \
    third_party_libvpx_libvpx_intrinsics_neon_gyp \
    third_party_webrtc_modules_video_render_module_impl_gyp \
    third_party_webrtc_modules_video_render_module_gyp \
    third_party_usrsctp_usrsctplib_gyp \
    third_party_libjingle_libpeerconnection_gyp \
    third_party_webrtc_voice_engine_voice_engine_gyp \
    third_party_webrtc_modules_audio_conference_mixer_gyp \
    third_party_webrtc_modules_audio_processing_gyp \
    third_party_webrtc_modules_audioproc_debug_proto_gyp \
    third_party_webrtc_modules_audio_processing_neon_gyp \
    lib_core_neon_offsets \
    third_party_webrtc_modules_audio_device_gyp \
    third_party_webrtc_modules_bitrate_controller_gyp \
    third_party_webrtc_modules_rtp_rtcp_gyp \
    third_party_webrtc_modules_paced_sender_gyp \
    third_party_webrtc_modules_remote_bitrate_estimator_gyp \
    third_party_webrtc_modules_remote_bitrate_estimator_rbe_components_gyp \
    third_party_webrtc_webrtc_gyp \
    third_party_webrtc_webrtc_common_gyp \
    third_party_webrtc_video_engine_video_engine_core_gyp \
    third_party_webrtc_modules_video_processing_gyp \
    components_cdm_browser_gyp \
    components_cdm_common_gyp \
    components_cdm_renderer_gyp \
    components_data_reduction_proxy_browser_gyp \
    components_data_reduction_proxy_common_gyp \
    components_navigation_interception_gyp \
    components_visitedlink_browser_gyp \
    components_visitedlink_common_gyp \
    components_visitedlink_renderer_gyp \
    content_content_app_both_gyp \
    v8_tools_gyp_v8_gyp \
    third_party_icu_icui18n_gyp \
    third_party_icu_system_icu_gyp \
    third_party_icu_icuuc_gyp  \
    third_party_WebKit_public_blink_gyp \
    third_party_WebKit_public_blink_resources_gyp \

#############################
#       GRAPHITE_OPTS #
#############################
LOCAL_DISABLE_GRAPHITE := \
    libunwind \
    libFFTEm \
    libicui18n \
    libskia \
    libvpx \
    libmedia_jni \
    libstagefright_mp3dec \
    libart \
    libstagefright_amrwbenc \
    libpdfium \
    libpdfiumcore \
    libwebviewchromium \
    libwebviewchromium_loader \
    libwebviewchromium_plat_support \
    libjni_filtershow_filters \
    fio \
    libwebrtc_spl \
    libpcap \
    libsigchain \
    libFraunhoferAAC 

GRAPHITE_FLAGS := \
    -fgraphite \
    -fgraphite-identity \
    -floop-flatten \
    -floop-parallelize-all \
    -ftree-loop-linear \
    -floop-interchange \
    -floop-strip-mine \
    -floop-block
#######################
#  END GRAPHITE_OPTS #
#######################

#######
# LTO #
#######

ifeq ($(ENABLE_LTO),true)
 ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
  ifneq ($(strip $(LOCAL_CLANG)),true)

LTO_CFLAGS := \
-flto=jobserver \
-fno-fat-lto-objects \
-fuse-linker-plugin \
-D__LTO__ \
-funit-at-a-time \
-flto-report # so we will see what it does and what is wrong

LTO_LDFLAGS := \
$($(combo_2nd_arch_prefix)TARGET_LTO_CFLAGS) -Wl,-flto

LOCAL_DISABLE_LTO := \
	libc \
	libc_bionic \
	libc_gdtoa \
	libc_netbsd \
	libc_freebsd \
	libc_dns \
	libc_openbsd \
	libc_cxa \
	libc_syscalls \
	libc_aeabi \
	libc_common \
	libc_nomalloc \
	libc_malloc \
	libc_stack_protector \
	libc_tzcode \
	libdl \
	libm \
	libjemalloc \
	libselinux \
	libcutils \
	e2fsprogs \
	libadf \
	healthd \
	mkfs.f2fs \
	adbd \
	init \
	libminui \
	liblogwrap \
	liblog \
	libext2_uuid \
	libext2_uuid_static \
	libext2_blkid \
	libfs_mgr \
	libvpx \
	third_party_libvpx_libvpx_gyp \
	libvpx_asm_offsets_vp8 \
	libvpx_asm_offsets_vpx_scale \
	third_party_libvpx_libvpx_intrinsics_neon_gyp \
	libwebrtc_audio_preprocessing \
	libwebrtc_system_wrappers \
	skia_skia_opts_gyp \
	ui_gfx_gfx_geometry_gyp \
	libutils \
	libpixelflinger \
	libziparchive \
	libEGL \
	libstagefright \
	lib_core_neon_offsets \
	libwebviewchromium \
	ipc_mojo_ipc_mojo_gyp \
	mojo_mojo_cpp_bindings_gyp \
	mojo_mojo_environment_chromium_gyp \
	mojo_mojo_environment_chromium_impl_gyp \
	mojo_mojo_common_lib_gyp \
	mojo_mojo_system_impl_gyp \
	mojo_mojo_application_bindings_gyp \
	storage_storage_gyp \
	sql_sql_gyp \
	third_party_sqlite_sqlite_gyp \
	libft2 \
	storage_storage_common_gyp \
	third_party_leveldatabase_leveldatabase_gyp \
	third_party_libwebp_libwebp_dec_gyp \
	third_party_libwebp_libwebp_dsp_gyp \
	third_party_libwebp_libwebp_dsp_neon_gyp \
	third_party_libwebp_libwebp_utils_gyp \
	third_party_libwebp_libwebp_demux_gyp \
	third_party_libwebp_libwebp_enc_gyp \
	third_party_ots_ots_gyp \
	third_party_brotli_brotli_gyp \
	third_party_qcms_qcms_gyp \
	v8_tools_gyp_v8_base_gyp \
	v8_tools_gyp_v8_libbase_gyp \
	v8_tools_gyp_v8_snapshot_gyp \
	third_party_iccjpeg_iccjpeg_gyp \
	third_party_openmax_dl_dl_openmax_dl_gyp \
	third_party_openmax_dl_dl_openmax_dl_armv7_gyp \
	third_party_libxml_libxml_gyp \
	third_party_libxslt_libxslt_gyp \
	gin_gin_gyp \
	third_party_libjingle_libjingle_gyp \
	third_party_libjingle_libjingle_p2p_constants_gyp \
	google_apis_google_apis_gyp \
	third_party_zlib_google_zip_gyp \
	third_party_zlib_minizip_gyp \
	content_browser_service_worker_proto_gyp \
	content_browser_speech_proto_speech_proto_gyp \
	content_content_child_gyp \
	content_content_utility_gyp \
	courgette_courgette_lib_gyp \
	third_party_lzma_sdk_lzma_sdk_gyp \
	content_content_common_mojo_bindings_gyp \
	cc_cc_surfaces_gyp \
	mojo_mojo_js_bindings_gyp \
	net_http_server_gyp \
	printing_printing_gyp \
	sandbox_sandbox_services_gyp \
	sandbox_seccomp_bpf_gyp \
	sandbox_seccomp_bpf_helpers_gyp \
	jingle_jingle_glue_gyp \
	third_party_libphonenumber_libphonenumber_gyp \
	third_party_libphonenumber_libphonenumber_without_metadata_gyp \
	third_party_fips181_fips181_gyp \
	third_party_libaddressinput_libaddressinput_util_gyp \
	content_content_renderer_gyp \
	cc_blink_cc_blink_gyp \
	media_blink_media_blink_gyp \
	mojo_mojo_js_bindings_lib_gyp \
	ui_native_theme_native_theme_gyp \
	third_party_libjingle_libjingle_webrtc_gyp \
	third_party_libjingle_libjingle_webrtc_common_gyp \
	third_party_libsrtp_libsrtp_gyp

ifeq (1,$(words $(filter $(LOCAL_DISABLE_LTO),$(LOCAL_MODULE))))
  ifdef LOCAL_CFLAGS
    LOCAL_CONLYFLAGS += -fno-lto
  else
    LOCAL_CONLYFLAGS := -fno-lto
  endif
  ifdef LOCAL_CPPFLAGS
    LOCAL_CPPFLAGS += -fno-lto
  else
    LOCAL_CPPFLAGS := -fno-lto
  endif
  ifndef LOCAL_LDFLAGS
    LOCAL_LDFLAGS := -Wl,-fno-lto
  else
    LOCAL_LDFLAGS += -Wl,-fno-lto
  endif
endif

ifneq (1,$(words $(filter $(LOCAL_DISABLE_LTO),$(LOCAL_MODULE))))
  ifdef LOCAL_CFLAGS
    LOCAL_CONLYFLAGS += $(LTO_CFLAGS)
  else
    LOCAL_CONLYFLAGS := $(LTO_CFLAGS)
  endif
  ifdef LOCAL_CPPFLAGS
    LOCAL_CPPFLAGS += $(LTO_CFLAGS)
  else
    LOCAL_CPPFLAGS := $(LTO_CFLAGS)
  endif
  ifndef LOCAL_LDFLAGS
    LOCAL_LDFLAGS := $(LTO_LDFLAGS)
  else
    LOCAL_LDFLAGS += $(LTO_LDFLAGS)
endif
endif

endif
endif
endif


# PThread
LOCAL_DISABLE_PTHREAD := \
       bluetooth \
       bluetooth.default \
       libc_netbsd

ifneq (1,$(words $(filter $(LOCAL_DISABLE_PTHREAD),$(LOCAL_MODULE))))
  ifdef LOCAL_CFLAGS
    LOCAL_CFLAGS += -pthread
  else
    LOCAL_CFLAGS := -pthread
  endif
endif

ifeq ($(SNAP),true)
LLVM_VERSION := 3.6
LLVM_NAME := llvm-Snapdragon_LLVM_for_Android_$(LLVM_VERSION)
LLVM_TOOLCHAIN_ROOT := $(NDK_ROOT)/toolchains/$(LLVM_NAME)
LLVM_TOOLCHAIN_PREBUILT_ROOT := $(call host-prebuilt-tag,$(LLVM_TOOLCHAIN_ROOT))
LLVM_TOOLCHAIN_PREFIX := $(LLVM_TOOLCHAIN_PREBUILT_ROOT)/bin/

TOOLCHAIN_VERSION := 4.8
TOOLCHAIN_NAME := arm-linux-androideabi-$(TOOLCHAIN_VERSION)
TOOLCHAIN_ROOT := $(NDK_ROOT)/toolchains/$(TOOLCHAIN_NAME)
TOOLCHAIN_PREBUILT_ROOT := $(call host-prebuilt-tag,$(TOOLCHAIN_ROOT))
TOOLCHAIN_PREFIX := $(TOOLCHAIN_PREBUILT_ROOT)/bin/arm-linux-androideabi-

TARGET_CC := $(LLVM_TOOLCHAIN_PREFIX)clang$(HOST_EXEEXT)
TARGET_CXX := $(LLVM_TOOLCHAIN_PREFIX)clang++$(HOST_EXEEXT)

#
# CFLAGS and LDFLAGS
#

TARGET_CFLAGS := \
    -gcc-toolchain $(call host-path,$(TOOLCHAIN_PREBUILT_ROOT)) \
    -fpic \
    -ffunction-sections \
    -funwind-tables \
    -fstack-protector \
    -Wno-invalid-command-line-argument \
    -Wno-unused-command-line-argument \
    -no-canonical-prefixes

# Disable integrated-as for better compatibility
TARGET_CFLAGS += \
    -fno-integrated-as

TARGET_LDFLAGS += \
    -gcc-toolchain $(call host-path,$(TOOLCHAIN_PREBUILT_ROOT)) \
    -no-canonical-prefixes

TARGET_C_INCLUDES := \
    $(SYSROOT_INC)/usr/include

ifneq ($(filter %armeabi-v7a,$(TARGET_ARCH_ABI)),)
    LLVM_TRIPLE := armv7-none-linux-androideabi

    TARGET_CFLAGS += -target $(LLVM_TRIPLE) \
                     -march=armv7-a \
                     -mfloat-abi=softfp \
                     -mfpu=vfpv3-d16

    TARGET_LDFLAGS += -target $(LLVM_TRIPLE) \
                      -Wl,--fix-cortex-a8
else
ifneq ($(filter %armeabi-v7a-hard,$(TARGET_ARCH_ABI)),)
    LLVM_TRIPLE := armv7-none-linux-androideabi

    TARGET_CFLAGS += -target $(LLVM_TRIPLE) \
                     -march=armv7-a \
                     -mfpu=vfpv3-d16 \
                     -mhard-float \
                     -D_NDK_MATH_NO_SOFTFP=1

    TARGET_LDFLAGS += -target $(LLVM_TRIPLE) \
                      -Wl,--fix-cortex-a8 \
                      -Wl,--no-warn-mismatch \
                      -lm_hard
else
    LLVM_TRIPLE := armv5te-none-linux-androideabi

    TARGET_CFLAGS += -target $(LLVM_TRIPLE) \
                     -march=armv5te \
                     -msoft-float

    TARGET_LDFLAGS += -target $(LLVM_TRIPLE)
endif
endif

TARGET_CFLAGS.neon := -mfpu=neon

TARGET_arm_release_CFLAGS :=  -O3 \
                              -g \
                              -DNDEBUG \
                              -fomit-frame-pointer \
                              -fstrict-aliasing

TARGET_thumb_release_CFLAGS := -mthumb \
                               -Os \
                               -g \
                               -DNDEBUG \
                               -fomit-frame-pointer \
                               -fno-strict-aliasing

# When building for debug, compile everything as arm.
TARGET_arm_debug_CFLAGS := $(TARGET_arm_release_CFLAGS) \
                           -O0 \
                           -UNDEBUG \
                           -fno-omit-frame-pointer \
                           -fno-strict-aliasing

TARGET_thumb_debug_CFLAGS := $(TARGET_thumb_release_CFLAGS) \
                             -O0 \
                             -UNDEBUG \
                             -marm \
                             -fno-omit-frame-pointer

# This function will be called to determine the target CFLAGS used to build
# a C or Assembler source file, based on its tags.
#
TARGET-process-src-files-tags = \
$(eval __arm_sources := $(call get-src-files-with-tag,arm)) \
$(eval __thumb_sources := $(call get-src-files-without-tag,arm)) \
$(eval __debug_sources := $(call get-src-files-with-tag,debug)) \
$(eval __release_sources := $(call get-src-files-without-tag,debug)) \
$(call set-src-files-target-cflags, \
    $(call set_intersection,$(__arm_sources),$(__debug_sources)), \
    $(TARGET_arm_debug_CFLAGS)) \
$(call set-src-files-target-cflags,\
    $(call set_intersection,$(__arm_sources),$(__release_sources)),\
    $(TARGET_arm_release_CFLAGS)) \
$(call set-src-files-target-cflags,\
    $(call set_intersection,$(__arm_sources),$(__debug_sources)),\
    $(TARGET_arm_debug_CFLAGS)) \
$(call set-src-files-target-cflags,\
    $(call set_intersection,$(__thumb_sources),$(__release_sources)),\
    $(TARGET_thumb_release_CFLAGS)) \
$(call set-src-files-target-cflags,\
    $(call set_intersection,$(__thumb_sources),$(__debug_sources)),\
    $(TARGET_thumb_debug_CFLAGS)) \
$(call add-src-files-target-cflags,\
    $(call get-src-files-with-tag,neon),\
    $(TARGET_CFLAGS.neon)) \
$(call set-src-files-text,$(__arm_sources),arm) \
$(call set-src-files-text,$(__thumb_sources),thumb)
endif
