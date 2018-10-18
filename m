Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 948AC600E3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 09:22:49 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id 61-v6so32817893wrb.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Oct 2018 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=qE7Lw8eTCfcN7DXlEc1453HgFWXC39jjCpY5GbbDztI=;
	b=e4w8ctcrBSiBbI6RGcPETsnk2+41lRRsPnF+6VSyYYSOf+TSebiMA++FXV5kOmEN/y
	AsSqs5q85kV4wizUWG6E5gt/hcqqxVcz9dtoFbxeIp5pR5oDhWFEwjcTBLENjJq5QQ5l
	qgJfaS4G6j4+Dcg5PRSBGYzhOaw5LLUK84ni8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=qE7Lw8eTCfcN7DXlEc1453HgFWXC39jjCpY5GbbDztI=;
	b=k8aqhB4kVOSRXCMfl9SnpqbCRpyVXGTiA5sqUSV8tx9n8vEdwklnKE+wPCKxYmNkdK
	D7OVSeAnzCidqtjk5H6AD242cQnSR4R8irsCH1tQik4AFSkBCyn5SKuSHFHQT3dN5fO2
	7eMCmt5p1MggrNk8w/zlVH0hKUJJ3z7lPitfIpAaIcJGY7ptMao2bsDunWEtcDGq5mgP
	eYCV49vMZnj6o9rRudeGkmKSyyviKvi9N2V/WfDrLN2i+KXjwu6eYYrkZPCQouDbCW1m
	sYvjrhkaC7e449hIomrFkVn1qA/o2EkPSEfoms/qd9K6TeUAwxINxIiVlCPER9JfnuaO
	HJCw==
X-Gm-Message-State: ABuFfoh0yDMM7zhQFHFuny2fUhQfZYwcr3X16YjjoFMXaaX2PW111DPk
	b7QSSHNv4SDcbvPOdjnGBJSYNxPsPKY=
X-Google-Smtp-Source: ACcGV62LDTOO3SEm3WCOWUYWxJKDrk4hkAp7rG/x3URTMrnqpycmZmRgxUoxvYnYtjktk6R9pwfZvw==
X-Received: by 2002:a5d:4c4d:: with SMTP id
	n13-v6mr25934153wrt.120.1539854569690; 
	Thu, 18 Oct 2018 02:22:49 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x17-v6sm17666494wrs.84.2018.10.18.02.22.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 02:22:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Oct 2018 10:22:41 +0100
Message-Id: <20181018092246.1445-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
References: <20181018092246.1445-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/7] data_smart: Micro optimise _remove handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 18 Oct 2018 09:22:49 -0000

This brings _remove handling into line with _append/_prepend with regard
to the parsing flag to getVarFlag.

This is an internal flag and the only times this is used is through getVar
during renameVar operations and when processing ?= operations to see if
a variable is set. In either case we don't need to process remove operations.

Therefore take the minor speedup and skip processing for parsing=True.

[YOCTO #10945]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 0a8488ca1b..7b2c0a8943 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -805,7 +805,7 @@ class DataSmart(MutableMapping):
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
 
-        if value and flag == "_content" and local_var is not None and "_remove" in local_var:
+        if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
             removes = []
             self.need_overrides()
             for (r, o) in local_var["_remove"]:
-- 
2.17.1


