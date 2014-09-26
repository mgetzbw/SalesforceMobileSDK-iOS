Pod::Spec.new do |s|

  s.name         = "SalesforceMobileSDK-iOS"
  s.version      = "3.0.0"
  s.summary      = "Salesforce Mobile SDK for iOS"
  s.homepage     = "https://github.com/forcedotcom/SalesforceMobileSDK-iOS"

  s.license      = { :type => "Salesforce.com Mobile SDK License", :file => "LICENSE.md" }
  s.author       = { "Kevin Hawkins" => "khawkins@salesforce.com" }

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/forcedotcom/SalesforceMobileSDK-iOS.git",
                     :branch => "unstable",
                     :submodules => true }

  s.prepare_command = <<-CMD
      sed -i -e 's/#import \\"Categories\\//#import \\"/g' external/MKNetworkKit/MKNetworkKit/MKNetworkKit.h
  CMD

  s.subspec 'OpenSSL' do |openssl|

      openssl.preserve_paths = 'external/ThirdPartyDependencies/openssl/openssl/*.h', 'external/ThirdPartyDependencies/openssl/openssl_license.txt'
      openssl.vendored_libraries = 'external/ThirdPartyDependencies/openssl/libcrypto.a', 'external/ThirdPartyDependencies/openssl/libssl.a'

  end

  s.subspec 'SQLCipher' do |sqlcipher|

      sqlcipher.preserve_paths = 'external/ThirdPartyDependencies/sqlcipher/LICENSE'
      sqlcipher.vendored_libraries = 'external/ThirdPartyDependencies/sqlcipher/libsqlcipher.a'

  end

  s.subspec 'SalesforceCommonUtils' do |commonutils|

      commonutils.source_files = 'external/ThirdPartyDependencies/SalesforceCommonUtils/Headers/SalesforceCommonUtils/*.h'
      commonutils.public_header_files = 'external/ThirdPartyDependencies/SalesforceCommonUtils/Headers/SalesforceCommonUtils/*.h'
      commonutils.header_dir = 'Headers/SalesforceCommonUtils'
      commonutils.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>'
      commonutils.vendored_libraries = 'external/ThirdPartyDependencies/SalesforceCommonUtils/libSalesforceCommonUtils.a'
      commonutils.frameworks = 'MessageUI'
      commonutils.libraries = 'z'
      commonutils.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }

  end

  s.subspec 'MKNetworkKit' do |mknet|

      mknet.source_files = 'external/MKNetworkKit/MKNetworkKit/**/*.{h,m}'
      mknet.public_header_files = 'external/MKNetworkKit/MKNetworkKit/Categories/NSDictionary+RequestEncoding.h', 'external/MKNetworkKit/MKNetworkKit/Categories/NSString+MKNetworkKitAdditions.h', 'external/MKNetworkKit/MKNetworkKit/Categories/UIAlertView+MKNetworkKitAdditions.h', 'external/MKNetworkKit/MKNetworkKit/MKNetworkEngine.h', 'external/MKNetworkKit/MKNetworkKit/MKNetworkKit.h', 'external/MKNetworkKit/MKNetworkKit/MKNetworkOperation.h'
      mknet.header_dir = 'Headers/MKNetworkKit-iOS'
      mknet.prefix_header_contents = '#import "MKNetworkKit.h"'
      mknet.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      mknet.requires_arc = true

  end

  s.subspec 'SalesforceSecurity' do |salesforcesecurity|

      salesforcesecurity.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      salesforcesecurity.source_files = 'shared/SalesforceSecurity/SalesforceSecurity/Classes/*.{h,m}'
      salesforcesecurity.public_header_files = 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFPasscodeManager.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFSDKCryptoUtils.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFEncryptionKey.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFPasscodeProviderManager.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFKeyStoreKey.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFKeyStoreManager.h', 'shared/SalesforceSecurity/SalesforceSecurity/Classes/SFPasscodeManager+Internal.h'
      salesforcesecurity.header_dir = 'Headers/SalesforceSecurity'
      salesforcesecurity.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>'
      salesforcesecurity.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      salesforcesecurity.requires_arc = true

  end

  s.subspec 'SalesforceOAuth' do |oauth|

      oauth.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      oauth.dependency 'SalesforceMobileSDK-iOS/SalesforceSecurity'
      oauth.source_files = 'shared/SalesforceOAuth/SalesforceOAuth/Classes/**/*.{h,m}'
      oauth.public_header_files = 'shared/SalesforceOAuth/SalesforceOAuth/Classes/SFOAuthCoordinator.h', 'shared/SalesforceOAuth/SalesforceOAuth/Classes/SFOAuthCredentials.h', 'shared/SalesforceOAuth/SalesforceOAuth/Classes/SFOAuthInfo.h'
      oauth.header_dir = 'Headers/SalesforceOAuth'
      oauth.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>'
      oauth.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      oauth.requires_arc = true

  end

  s.subspec 'SalesforceSDKCore' do |sdkcore|

      sdkcore.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      sdkcore.dependency 'SalesforceMobileSDK-iOS/SalesforceSecurity'
      sdkcore.dependency 'SalesforceMobileSDK-iOS/SalesforceOAuth'
      sdkcore.dependency 'SalesforceMobileSDK-iOS/OpenSSL'
      sdkcore.dependency 'SalesforceMobileSDK-iOS/SQLCipher'
      sdkcore.source_files = 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/**/*.{h,m}'
      sdkcore.public_header_files = 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Fmdb/FMDatabase.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Fmdb/FMResultSet.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/NSURL+SFStringUtils.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAbstractPasscodeViewController.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFApplication.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthErrorHandler.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthErrorHandlerList.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthenticationManager+Internal.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthenticationManager.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthenticationViewHandler.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFAuthorizingViewController.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFCommunityData.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFDefaultUserManagementViewController.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFDirectoryManager.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Identity/SFIdentityCoordinator.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Identity/SFIdentityData.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFJsonUtils.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFPreferences.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/PushNotification/SFPushNotificationManager.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFQuerySpec.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFSDKResourceUtils.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/SFSDKTestCredentialsData.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/SFSDKTestRequestListener.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Util/SFSDKWebUtils.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFSecurityLockout.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFSmartStore.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFSmartStoreDatabaseManager.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFSmartStoreInspectorViewController.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFSoupIndex.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/SmartStore/SFStoreCursor.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccount.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountConstants.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountIdentity.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Security/SFUserAccountManager.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SFUserActivityMonitor.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Common/SalesforceSDKConstants.h', 'shared/SalesforceSDKCore/SalesforceSDKCore/Classes/Test/TestSetupUtils.h'
      sdkcore.header_dir = 'Headers/SalesforceSDKCore'
      sdkcore.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>', '#import "SalesforceSDKConstants.h"'
      sdkcore.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers", 'OTHER_CFLAGS' => '-DSQLITE_HAS_CODEC' }
      sdkcore.requires_arc = true

  end

  s.subspec 'SalesforceNetworkSDK' do |networksdk|

      networksdk.dependency 'SalesforceMobileSDK-iOS/MKNetworkKit'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SalesforceOAuth'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSecurity'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      networksdk.dependency 'SalesforceMobileSDK-iOS/OpenSSL'
      networksdk.dependency 'SalesforceMobileSDK-iOS/SQLCipher'
      networksdk.source_files = 'shared/SalesforceNetworkSDK/SalesforceNetworkSDK/*.{h,m}'
      networksdk.public_header_files = 'shared/SalesforceNetworkSDK/SalesforceNetworkSDK/SFNetworkEngine.h', 'shared/SalesforceNetworkSDK/SalesforceNetworkSDK/SFNetworkOperation.h', 'shared/SalesforceNetworkSDK/SalesforceNetworkSDK/SFNetworkUtils.h', 'shared/SalesforceNetworkSDK/SalesforceNetworkSDK/SFNetworkCoordinator.h'
      networksdk.header_dir = 'Headers/SalesforceNetworkSDK'
      networksdk.prefix_header_contents = '#import <SalesforceCommonUtils/SalesforceCommonUtils.h>'
      networksdk.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      networksdk.requires_arc = true

  end

  s.subspec 'SalesforceNativeSDK' do |nativesdk|

      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceNetworkSDK'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/MKNetworkKit'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceOAuth'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSecurity'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/OpenSSL'
      nativesdk.dependency 'SalesforceMobileSDK-iOS/SQLCipher'
      nativesdk.source_files = 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/*.{h,m}'
      nativesdk.public_header_files = 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/SFRestAPI+QueryBuilder.h', 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/SFRestRequest.h', 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/SFRestAPI+Files.h', 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/SFRestAPI+Blocks.h', 'native/SalesforceNativeSDK/SalesforceNativeSDK/Classes/SFRestAPI.h'
      nativesdk.header_dir = 'Headers/SalesforceNativeSDK'
      nativesdk.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>'
      nativesdk.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      nativesdk.requires_arc = true

  end

  s.subspec 'SmartSync' do |smartsync|

      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceNativeSDK'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceNetworkSDK'
      smartsync.dependency 'SalesforceMobileSDK-iOS/MKNetworkKit'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceOAuth'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceSecurity'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceSDKCore'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SalesforceCommonUtils'
      smartsync.dependency 'SalesforceMobileSDK-iOS/OpenSSL'
      smartsync.dependency 'SalesforceMobileSDK-iOS/SQLCipher'
      smartsync.source_files = 'native/SmartSync/SmartSync/Classes/**/*.{h,m}'
      smartsync.public_header_files = 'native/SmartSync/SmartSync/Classes/Manager/SFSmartSyncCacheManager.h', 'native/SmartSync/SmartSync/Classes/Manager/SFSmartSyncMetadataManager.h', 'native/SmartSync/SmartSync/Classes/Manager/SFSmartSyncNetworkManager.h', 'native/SmartSync/SmartSync/Classes/Model/SFObject.h', 'native/SmartSync/SmartSync/Classes/Model/SFObjectType.h', 'native/SmartSync/SmartSync/Classes/Model/SFObjectTypeLayout.h', 'native/SmartSync/SmartSync/Classes/Util/SFSmartSyncConstants.h', 'native/SmartSync/SmartSync/Classes/Util/SFSmartSyncObjectUtils.h', 'native/SmartSync/SmartSync/Classes/Util/SFSmartSyncSoqlBuilder.h', 'native/SmartSync/SmartSync/Classes/Util/SFSmartSyncSoslBuilder.h', 'native/SmartSync/SmartSync/Classes/Util/SFSmartSyncSoslReturningBuilder.h'
      smartsync.header_dir = 'Headers/SmartSync'
      smartsync.prefix_header_contents = '#import <SalesforceCommonUtils/SFLogger.h>'
      smartsync.xcconfig = { 'HEADER_SEARCH_PATHS' => "${PODS_ROOT}/Headers/#{s.name}/Headers" }
      smartsync.requires_arc = true

  end

end