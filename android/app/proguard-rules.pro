# Existing Stripe rules
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

# Existing Keep Rules for Push SDKs
-keep class com.heytap.** { *; }
-keep class com.huawei.** { *; }
-keep class com.vivo.** { *; }
-keep class com.xiaomi.** { *; }

# New Additions Based on Missing Classes

# Oppo Push SDK
-dontwarn com.heytap.msp.push.**
-keep class com.heytap.msp.push.** { *; }

# Huawei Push SDK
-dontwarn com.huawei.hms.**
-keep class com.huawei.hms.** { *; }

# Vivo Push SDK
-dontwarn com.vivo.push.**
-keep class com.vivo.push.** { *; }
-dontwarn com.vivo.push.listener.**
-keep class com.vivo.push.listener.** { *; }
-dontwarn com.vivo.push.model.**
-keep class com.vivo.push.model.** { *; }

# Xiaomi Push SDK
-dontwarn com.xiaomi.mipush.sdk.**
-keep class com.xiaomi.mipush.sdk.** { *; }

# Conscrypt (OkHttp dependency)
-dontwarn org.conscrypt.**
-keep class org.conscrypt.** { *; }

# Jackson Library
-dontwarn java.beans.**
-keep class java.beans.** { *; }

# DOM Implementation (XML parsing dependencies)
-dontwarn org.w3c.dom.bootstrap.**
-keep class org.w3c.dom.bootstrap.** { *; }

# Add this to prevent warnings about other libraries
-dontwarn javax.annotation.**

# General Rules to Avoid Missing Class Errors
-dontwarn **.R$*
-dontwarn **.R
-dontwarn **.BuildConfig
-dontwarn kotlin.**
-dontwarn androidx.**

# Optimization Suggestions
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepnames class * {
    *;
}
-keep class * implements java.io.Serializable { *; }
