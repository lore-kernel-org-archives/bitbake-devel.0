Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F55C02194
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:29:10 +0000 (UTC)
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web10.52712.1737988145023473132
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:29:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=da9DCpbl;
 spf=pass (domain: gmail.com, ip: 209.85.166.66, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-844d7f81dd1so127306439f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988144; x=1738592944; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSCB9eh+bU/55xqpfWTqLMsxHgl/mB40gfwKsi24peM=;
        b=da9DCpblO0fIxhuKmQu18XVZNMb6lvqAWuRUB/CEb7QlD+F1umEhMY5ytkYxQqh97S
         8TNaTVhFIpu6L0Ri8URxoFnrJcvcnTQ4Dk8W8ekdSu96XKq3n+YFA1kGO3BkYxSjwPkj
         V+X3hKQshRG3Heoz583dyAyUKbaYmjAIl91VBjrNtbrXaK5Ec1IxkUkD/4gDcQFhs11W
         L89LTfOKQx+kUUVlvzFne1sPAXh7GsCynfSlWs19T0wReCTbX+99OXrB3WNq/bRaVgW8
         OZcnyrjc4xmYunq3j3s8d3v4FPX9ZBB9T572tBSf+7Avj8O0YpN8fw8WT7I+9nnKZzKG
         fH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988144; x=1738592944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSCB9eh+bU/55xqpfWTqLMsxHgl/mB40gfwKsi24peM=;
        b=hoR2b715Jrgcpg3sO8hO532SkJntHNCB3zw4Us8lfPNQcWhg99IKnPELrWmmNKjreF
         YMThdfnnStWm1QMREJZ1+1bKqdLsFAOEzo/tOxcR429OwRQGbUeF05W+1HQC3swsZ9Ky
         C5nbXBw++KtdySGE/jufft65Fc4mV1RSKcMm3yyNAIm95nf6D6LAINKBotSfnAqYzXWa
         dsO06+fi4km3+R9BdnHDX23qt+6OzLu08RzS7CYBs5Hei8QemCXq7DzKDHF7KpNeU1P9
         R7PKzO3Ld5O0OwinLRNixF0pWhj1teIgLQHd5AuAShPOeuba4FgsgvMldwkm4R7vl3S+
         yK3g==
X-Gm-Message-State: AOJu0YzVBpZRNC+aIjtJspm6DaQtgELqVHwXjqW0P3jgB+JZpyS+5FBh
	tGqD4oatTXBchwIYyCAkLOMsQSNZwCeGt1KRd30x8OJ9N4SRusHBacKxQPg9dK4=
X-Gm-Gg: ASbGnct136Hc3fnTF6tv5P5Qu4BvwP3YLNGN1sQ1UqccR+9oGipK2s3+idKK04ESKrT
	xQPmMfVdhvxpfk2qcrL+bm+ygf0fP0BG+AY9ZFPu/XR26WKl3oZBVcyAeJn5vUS7GgAwDmmy388
	ma5mRr370Iy5QrA6Yw1IZCg32YgAVfESVsCGQxtkI+KHEc/E0/SkqmZqZo1FBxpDa64QANoQITU
	Nc85/C/hV9PkYt3w3nA153YeNVCxrwT1kl2zKxzT6RitBk7BheoKRviNwQfSvR9H5bA1iZzPr1F
	u5DZdkWvUBhf80xWua9saqgzvsKJtQf/bjM0AbvLrWeM5jsz8SmrcHi1fMqVmuzSJ10x4/X30A6
	d8YbCgpxkUbTy
X-Google-Smtp-Source: AGHT+IGk/DraOOg8WGOYGJJE5+ZZ6l41sXnxZOk12QZYXXobrRp1cpI+09U4nVLTj7y0G9RM3zKBww==
X-Received: by 2002:a05:6e02:248d:b0:3ce:5a7c:6b5d with SMTP id e9e14a558f8ab-3cf743aba4amr368375315ab.2.1737988144017;
        Mon, 27 Jan 2025 06:29:04 -0800 (PST)
Received: from 95d5ae3229ef.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc744be43sm26228645ab.33.2025.01.27.06.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:29:03 -0800 (PST)
From: eric.meyers15310@gmail.com
X-Google-Original-From: eric.meyers@arthrex.com
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>
Subject: [PATCH 1/3] fetch2/npm: Add basic auth credential support for npm fetcher
Date: Mon, 27 Jan 2025 14:29:16 +0000
Message-Id: <20250127142918.163-2-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127142918.163-1-eric.meyers@arthrex.com>
References: <20250127142918.163-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:29:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17097

From: Eric Meyers <eric.meyers@arthrex.com>

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
---
 lib/bb/fetch2/npm.py | 64 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ac76d64cd..4bf59dd1e 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -21,6 +21,15 @@ Supported SRC_URI options are:
 
 - destsuffix
     Specifies the directory to use to unpack the package (default: npm).
+
+- namespace
+   The npm namespace name (without the preceding "@").
+
+- username
+    Specifies the basic auth username to use when accessing the npm registry.
+
+- password
+    Specifies the basic auth password (or API key) to use when accessing the npm registry.
 """
 
 import base64
@@ -82,6 +91,33 @@ def npm_unpack(tarball, destdir, d):
     runfetchcmd(cmd, d, workdir=destdir)
     runfetchcmd("chmod -R +X '%s'" % (destdir), d, quiet=True, workdir=destdir)
 
+def create_npmrc_file(registry, namespace=None, username=None, password=None):
+    """Creates a npmrc file with authentication credentials populated based on provided username and password"""
+
+    # Create a temporary file we can store the npm authentication within
+    npmrc_file = tempfile.NamedTemporaryFile(mode="w", buffering=1).name
+
+    # Convert "username:password" string into base64 auth string
+    base64_auth_string = base64.b64encode(f"{username}:{password}".encode('utf-8')).decode('utf-8')
+
+    # Remove protocol from registry URL
+    registry = registry.replace('https://', '').replace('http://', '')
+
+    # Create the npmrc file with the authentication parameters
+    npm_auth_string = f"//{registry}/:_auth=\"{base64_auth_string}\""
+
+    with open(npmrc_file, 'w') as file:
+        file.write(npm_auth_string)
+        file.write("\n")
+
+        # Add namespace registry string if namespace is provided
+        if namespace:
+            npm_registry_string = f"@{namespace}:registry=https://{registry}"
+            file.write(npm_registry_string)
+            file.write("\n")
+
+    return npmrc_file
+
 class NpmEnvironment(object):
     """
     Using a npm config file seems more reliable than using cli arguments.
@@ -142,6 +178,9 @@ class Npm(FetchMethod):
         ud.package = None
         ud.version = None
         ud.registry = None
+        ud.username = None
+        ud.password = None
+        ud.namespace = None
 
         # Get the 'package' parameter
         if "package" in ud.parm:
@@ -154,6 +193,16 @@ class Npm(FetchMethod):
         if "version" in ud.parm:
             ud.version = ud.parm.get("version")
 
+        if "username" in ud.parm:
+            ud.username = ud.parm.get("username")
+
+        if "password" in ud.parm:
+            ud.password = ud.parm.get("password")
+
+        if "namespace" in ud.parm:
+            ud.namespace = ud.parm.get("namespace")
+            ud.package = f"@{ud.namespace}/{ud.package}"
+
         if not ud.version:
             raise MissingParameterError("Parameter 'version' required", ud.url)
 
@@ -189,7 +238,16 @@ class Npm(FetchMethod):
             args.append(("registry", ud.registry))
             pkgver = shlex.quote(ud.package + "@" + ud.version)
             cmd = ud.basecmd + " view %s" % pkgver
-            env = NpmEnvironment(d)
+
+            # Create an npmrc file if a username and password was supplied to the npm SRC_URI
+            npmrc_file = None
+            if (ud.username is not None and ud.password is not None):
+                try:
+                    npmrc_file = create_npmrc_file(ud.registry, ud.namespace, ud.username, ud.password)
+                except Exception as e:
+                    bb.warn(f"Error creating npmrc file: {e}")
+
+            env = NpmEnvironment(d, [], npmrc=npmrc_file)
             check_network_access(d, cmd, ud.registry)
             view_string = env.run(cmd, args=args)
 
@@ -224,6 +282,10 @@ class Npm(FetchMethod):
             uri = URI(tarball_url)
             uri.params["downloadfilename"] = ud.localfile
 
+            if (ud.username is not None and ud.password is not None):
+                uri.params["user"] = ud.username
+                uri.params["pswd"] = ud.password
+
             integrity = view.get("dist", {}).get("integrity")
             shasum = view.get("dist", {}).get("shasum")
 

