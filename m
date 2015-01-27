Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 8F290718E4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:33 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id fb4so5183639wid.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=A+vYbM6x1B4i36MyZdStRKyUXHRyfVnBoj3tqAup4vI=;
	b=SjYwNTcyJON57DjZ8IzkT1q98yUUaqU8pv1wJAA6UmImHF8wPF5wZm+4VvK91Mvtsu
	+YjJ429XtlU3TNxrCBTzfkXOEY2UQPGj6i0jEEIxawJ/vGBtteft5hrTWq53YlT7IeZJ
	Z5UcaQ7XthOBVx60hBvo0+TcnCSnmgJ+85xXFwX2I0+H58kQ+Hs0hGa9MnefLv6MY9kA
	0+y1cC0IsTLSIlog0pR/MOXY/ksxlLpOrzeQKzEbxuf0az+dLIGAvjL/UbN3FapaTgK2
	ocntXrOWhj/1BIK9lBGlFT9/qzfpT2iAM06K+HhPWqPy9tqsnDioXsPa+7MK/fclySYT
	gVOA==
X-Gm-Message-State: ALoCoQncVJEPZLOKtZpv6xq2UG856CnR9IL3OWuvgqSJSRvm7aQJuclE/UwhjKDW9a4a+7EOT/Za
X-Received: by 10.194.91.199 with SMTP id cg7mr3448015wjb.114.1422368853824;
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dj4sm2045083wjc.13.2015.01.27.06.27.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A6B995622F5; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:24 +0000
Message-Id: <48123b53d66de01ad6273140aa148276d63707ba.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 03/14] toastergui: Generic message for the layer details empty states
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:38 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the layer details page, change the message you see when
the number of targets or machines provided by a layer is
0, either because that's what's reported by a layer index
instance, or because Toaster does not have any information
about the layer.

The new message is more generic, in order to fit layers from
all layer sources.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 9286df6..207197bce 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -184,9 +184,7 @@
                 <div name="targets" id="targets" class="tab-pane">
                   {% if total_targets == 0 %}
                   <div class="alert alert-info">
-                    <strong>There is no target data for {{layerversion.layer.name}} ... yet</strong> <br />
-                    Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
-                    here the targets it provides.
+                    There is no target information for the <strong> {{layerversion.layer.name}} </strong> layer.
                   </div>
                   {% else %}
 
@@ -313,9 +311,7 @@
                 <div name="machines" id="machines" class="tab-pane">
                   {% if total_machines == 0 %}
                   <div class="alert alert-info">
-                    <strong>There is no machine data for {{layerversion.layer.name}} ... yet</strong> <br />
-                    Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
-                    here the machines it provides.
+                    There is no machine information for the <strong>{{layerversion.layer.name}}</strong> layer.
                   </div>
                   {% else %}
 
-- 
1.9.1


