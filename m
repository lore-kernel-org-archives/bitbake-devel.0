Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
 by mx.groups.io with SMTP id smtpd.web10.3050.1592902879399771730
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 02:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=qDKZ7deX;
 spf=pass (domain: gmail.com, ip: 209.85.208.67, mailfrom: onea.alex@gmail.com)
Received: by mail-ed1-f67.google.com with SMTP id dg28so157535edb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgXUh7CKWyzlLfXuNMzKAHQLKGQ8Zz9Ak/aDEEjOpHw=;
        b=qDKZ7deXXqcbO3RRB1hewINDYDN4t4xNOXd8/S1Z5CeoDr+lGP1h7pcEayaY7EtHKE
         Dux/UyIPRq81nol+C59wcqM3S8XbhbVwQRlgCjnyRHXoqSHR+MxcRE3JnqYz+/DbuvV8
         nqQVRb4ICk4HcE45m356BnxyjY3CG0NZlyzFE5F6PwM/fnro0llODaSCKPKj0lJ5ckEq
         9RaWACOOz97nKVNk79pqL2Y9j1o2F/wKPskXbXqIgBcDPrU+Ojo9FWOmAf64EqFfBjfa
         ofWnLgfIsNlRLjKTGXH787Rx7b6ZrcxRyAyQ9OUmUKy0w9qu+zS8mTPzvnegJ2u2X8zb
         RFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgXUh7CKWyzlLfXuNMzKAHQLKGQ8Zz9Ak/aDEEjOpHw=;
        b=PDKMsToKg6tg59686pSZw5yZLBErzmU7G5be+GHPelc/GQFjYv26+4i7ZYpW9uNxoh
         KYSFNmSp04ZEyrMY77lugL/EVzau5pZxoY8Efw1sBo8P2gulYbla1a3zqrZFiAEYMjNG
         wuStjVm2NcPC3UI8476dG0+YLRhPxizODzMLsQCNYyDyxqPDho9MVO3LaIcMV3DreI/G
         k2HBj8uAu5JqPgTFfB1zYz0R8c/eM21I77jAXMw0rwXE+3SIYPPlZMNo7+c8DYlXoHgL
         U42uCthqUh/Ru+t/s6RFcR1UHyUresVtkzRIzemc08+OZCZLBExt8AYVOuDtk3yobMiB
         0WGA==
X-Gm-Message-State: AOAM533D9Rf6tQ8QVb5Qs9ta354Fwzvx+rIVaTZcSPp3z43/mrQoKykg
	2Y19Ph58L40MK21sR3oFB5maT1hjolwKmQ==
X-Google-Smtp-Source: ABdhPJywMf2GuxOjK5X8lVatZZ8bCvXp+ookIA16r2P4z/0Mx5p8sPRJEfgdd3yTgaNzlyCBm2gO3A==
X-Received: by 2002:a05:6402:1604:: with SMTP id f4mr21580341edv.379.1592902877584;
        Tue, 23 Jun 2020 02:01:17 -0700 (PDT)
Return-Path: <onea.alex@gmail.com>
Received: from localhost.localdomain ([82.76.227.25])
        by smtp.gmail.com with ESMTPSA id k23sm13229119ejk.114.2020.06.23.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:01:16 -0700 (PDT)
From: "Alexandru N. Onea" <onea.alex@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Alexandru N. Onea" <onea.alex@gmail.com>
Subject: [PATCH v2 3/3] bitbake-user-manual: update perforce fetcher docs
Date: Tue, 23 Jun 2020 12:00:51 +0300
Message-Id: <20200623090051.85367-3-onea.alex@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623090051.85367-1-onea.alex@gmail.com>
References: <20200623090051.85367-1-onea.alex@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the perforce documentation by describing two new
parameters: module and remotepath.

Additionally, a general statement regarding the fetcher implementation
has been added, to make it clear that the fetcher does not use a
perforce client for the job.

Signed-off-by: Alexandru N. Onea <onea.alex@gmail.com>
---
 .../bitbake-user-manual-fetching.xml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index d1bfc233..fe4372ad 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -736,6 +736,10 @@
                 The fetcher's temporary working directory is set by
                 <link linkend='var-bb-P4DIR'><filename>P4DIR</filename></link>,
                 which defaults to "DL_DIR/p4".
+                The fetcher does not make use of a perforce client, instead it
+                relies on <filename>p4 files</filename> to retrieve a list of
+                files and <filename>p4 print</filename> to transfer the content
+                of those files locally.
             </para>
 
             <para>
@@ -783,6 +787,62 @@
                     to <filename>"${WORKDIR}/p4"</filename> in your recipe.
                 </note>
             </para>
+
+            <para>
+                By default, the fetcher strips the depot location from the
+                local file paths. In the above example, the content of
+                <filename>example-depot/main/source/</filename>
+                will be placed in <filename>${WORKDIR}/p4</filename>.
+                For situations where preserving parts of the remote depot paths
+                locally is desirable, the fetcher supports two parameters:
+
+                <itemizedlist>
+                    <listitem><para>
+                        <emphasis>"module":</emphasis>
+                        The top-level depot location or directory to fetch. The
+                        value of this parameter can also point to a single file
+                        within the depot, in which case the local file path will
+                        include the module path.
+                    </para></listitem>
+                    <listitem><para>
+                        <emphasis>"remotepath":</emphasis>
+                        When used with the value "<filename>keep</filename>",
+                        the fetcher will mirror the full depot paths locally
+                        for the specified location, even in combination with
+                        the <filename>module</filename> parameter.
+                    </para></listitem>
+                </itemizedlist>
+            </para>
+
+            <para>
+                Here is an example use of the the <filename>module</filename>
+                parameter:
+
+                <literallayout class='monospaced'>
+    SRC_URI = "p4://user:passwd@example-depot/main;module=source/..."
+                </literallayout>
+
+                In this case, the content of the top-level directory
+                <filename>source/</filename>  will be fetched to
+                <filename>${P4DIR}</filename>, including the directory itself.
+                The top-level directory will be accesible at
+                <filename>${P4DIR}/source/</filename>.
+            </para>
+
+            <para>
+                Here is an example use of the the <filename>remotepath</filename>
+                parameter:
+
+                <literallayout class='monospaced'>
+    SRC_URI = "p4://user:passwd@example-depot/main;module=source/...;remotepath=keep"
+                </literallayout>
+
+                In this case, the content of the top-level directory
+                <filename>source/</filename>  will be fetched to
+                <filename>${P4DIR}</filename>, but the complete depot paths will
+                be mirrored locally. The top-level directory will be accessible
+                at <filename>${P4DIR}/example-depot/main/source/</filename>.
+            </para>
         </section>
 
         <section id='repo-fetcher'>
-- 
2.25.1

