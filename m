Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web12.6711.1602575154524021315
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2020 00:45:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dfHdZVow;
 spf=pass (domain: linaro.org, ip: 209.85.210.53, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-ot1-f53.google.com with SMTP id m13so18181653otl.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2020 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6pZWOzXqE8nK7AMwjvBMBfe4mJC2dWELU/h4o9155U=;
        b=dfHdZVowioSl8l30nQ1Aodtx03SXWFmZjrtqPNfLDVYxitBtTcexxy1xmypJhvkzFn
         tWY8rX4EnNi3BDNoFZJCx3DtmcPKNd60VBXQdQUa7Eo/6wgVYdmKX9qQf+CLLjFVPOG9
         cmJrKp+mRzc+CvVecWDLW6rufUC0VY44a/19C2yPv0aDuUI8C0wb3Sl2qL1Xq3Dl6Xfw
         E3cb0Auidery4zkodCVMvljYJUcxqNx+tUQntC2czwk0aYCEIN0NYMUlgaq3mdvVnsEG
         Sh4F6t+z6p9ipHjcQF+WUIOlCnUs9T221mcO+9/8569teBj4joG/f9vd+OVNCgFjVbnW
         gTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6pZWOzXqE8nK7AMwjvBMBfe4mJC2dWELU/h4o9155U=;
        b=b/zwReTanaDyuQ1gI319JQ5O+6gAEHpCyWg4FLH13obvyrRyFAQm7pVqwGLoPOvUKY
         VYtUW9y6t0nPKS/g99bL2FdJf95oxM+ZdmzKqIFzCM4MPX6v9A0ifuB8oAv3Y2AdphxP
         YfTLhd4wdGtlkbimd3RvELdu3kwMrurXW7Yf92yC95YRxb91UEaZgm4w6xJk/npmEGks
         /ayqT7tLBXgKrbCBU9kdaefH0FctlEOc2UX0l2etLHNAK2QZ3wzNUJUFB+DDLmIdE7R5
         A/h60Ay9AN79cRRfIEzQTicEAtC1cvzz5IeRVwVmQ/glxcvVOFdb+c7JDIxVAnBYPwpR
         Mi9w==
X-Gm-Message-State: AOAM530QcBqcuU9+hqpaPtu9VIYI4Py6r8XJjIgJdGv5csM0gZoBjLUn
	b9rEGUzgsvpFXzMsrU5WmM/jiw==
X-Google-Smtp-Source: ABdhPJxtipcVNoesTKKUqmHy35+ZMg8OSDXr+6oIVjGEAKUxzHoBL0fKXiNpUna45OT6ZrWKmooiAA==
X-Received: by 2002:a9d:7a9:: with SMTP id 38mr23023589oto.280.1602575153609;
        Tue, 13 Oct 2020 00:45:53 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from nikaia.localdomain ([2a01:e0a:1b9:3e10:d6af:c5d9:8b6e:b994])
        by smtp.gmail.com with ESMTPSA id o2sm10613206oia.42.2020.10.13.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:45:52 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: steve@sakoman.com,
	bitbake-devel@lists.openembedded.org
Cc: Konrad Weihmann <kweihmann@outlook.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [dunfell][1.46][PATCH] bitbake-user-manual: Add BBFILES_DYNAMIC
Date: Tue, 13 Oct 2020 09:45:37 +0200
Message-Id: <20201013074537.41846-1-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Weihmann <kweihmann@outlook.com>

- add missing entry for BBFILES_DYNAMIC, ported from yocto-docs
- add description for the new inverse mode

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9186ca47ce73b4d1c87eb69163698a04679fb55c)
Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 .../bitbake-user-manual-ref-variables.xml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index c4bd1f25..4c29b246 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1124,6 +1124,67 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-BBFILES_DYNAMIC'><glossterm>BBFILES_DYNAMIC</glossterm>
+            <info>
+                BBFILES_DYNAMIC[doc] = "Activates content depending on presence of identified layers."
+            </info>
+            <glossdef>
+                <para role="glossdeffirst">
+                    Activates content depending on presence of identified layers.
+                    You identify the layers by the collections that the layers
+                    define.
+                </para>
+
+                <para>
+                    Use the <filename>BBFILES_DYNAMIC</filename> variable to
+                    avoid <filename>.bbappend</filename> files whose
+                    corresponding <filename>.bb</filename> file is in a layer
+                    that attempts to modify other layers through
+                    <filename>.bbappend</filename> but does not want to
+                    introduce a hard dependency on those other layers.
+                </para>
+
+                <para>
+                    Additionally you can prefix the rule with "!" to add 
+                    <filename>.bbappend</filename> and <filename>.bb</filename> files
+                    in case a layer is not present.
+                    Use this avoid hard dependency on those other layers.
+                </para>
+
+                <para>
+                    Use the following form for
+                    <filename>BBFILES_DYNAMIC</filename>:
+                    <literallayout class='monospaced'>
+                        <replaceable>collection_name</replaceable>:<replaceable>filename_pattern</replaceable>
+                    </literallayout>
+                    The following example identifies two collection names and
+                    two filename patterns:
+                    <literallayout class='monospaced'>
+                        BBFILES_DYNAMIC += "\
+                            clang-layer:${LAYERDIR}/bbappends/meta-clang/*/*/*.bbappend \
+                            core:${LAYERDIR}/bbappends/openembedded-core/meta/*/*/*.bbappend \
+                        "
+                    </literallayout>
+                    When the collection name is prefixed with "!" it will add the file pattern in case
+                    the layer is absent:
+                    <literallayout class='monospaced'>
+                        BBFILES_DYNAMIC += "\
+                            !clang-layer:${LAYERDIR}/backfill/meta-clang/*/*/*.bb \
+                        "
+                    </literallayout>
+                    
+                    This next example shows an error message that occurs
+                    because invalid entries are found, which cause parsing to
+                    abort:
+                    <literallayout class='monospaced'>
+                    ERROR: BBFILES_DYNAMIC entries must be of the form {!}&lt;collection name&gt;:&lt;filename pattern&gt;, not:
+                        /work/my-layer/bbappends/meta-security-isafw/*/*/*.bbappend
+                        /work/my-layer/bbappends/openembedded-core/meta/*/*/*.bbappend
+                    </literallayout>
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-bb-BBINCLUDED'><glossterm>BBINCLUDED</glossterm>
             <glossdef>
                 <para>
-- 
2.28.0

