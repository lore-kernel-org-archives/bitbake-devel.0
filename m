Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id D72A572CEE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:35 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id x13so15127112wgg.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=v/Ht+lDBwJz6HxogHMdZ6hrz9mE6LVIJoUPlMDRWDcc=;
	b=Dbqha+e1ec4DydZLSMTTlCIxUjlOl2j9+77ukv9A9IIDGr+AlZxIuf509FrY8icGNK
	WY2ovBffsXU138dwYZck0o1VFDb0dNBmbmwE53+p9TjxLrYyw4Q5gISEotCmQlijwKGn
	IrUqvrtRCa7RkCISWyzBPFyyrgJIU4MTX1vWwAiAPo3eilNxfxs+7PaLEeDWVV6wiQab
	lnmmfBB+kc6HQhI3jhzPsKy/au7NoVH9Z5K2HyzzsRaC2cl43mvVKm0Rnd50bQUXT7QJ
	WG8WA0KstQUiDltpWm69N0TnJKk2L7TBlvGdvaTmXaxMXNSD8Jv/fzyTDMpJ4atT4OQu
	dczg==
X-Gm-Message-State: ALoCoQmLdoY6hzTlDkG5N8nWhpxEIG3Jo7WuOeXdvQHoiuovGrFYMW3OxIin7bVuIwbSpKFRrEwB
X-Received: by 10.194.108.162 with SMTP id hl2mr346230wjb.134.1422368856182;
	Tue, 27 Jan 2015 06:27:36 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id lq5sm2023241wjb.35.2015.01.27.06.27.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AB06056232E; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:27 +0000
Message-Id: <2c576552118bcfe65d375ff809b3b4a4916da225.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 06/14] toastergui: give the add dependencies form some breathing space
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the editable version of the layer details page, the form to
add dependencies needs some distance from the dependency list.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index cb27342..1095254 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -206,6 +206,7 @@ dl textarea { resize: vertical; }
 .new-build form { margin: 5px 0 0; }
 .new-build .input-append { margin-bottom: 0; }
 #build-selected { margin-top: 15px; }
+div.add-deps { margin-top: 15px; }
 
 
 .animate-repeat {
-- 
1.9.1


