Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id AE57F76618
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:42 +0000 (UTC)
Received: by wibud3 with SMTP id ud3so28091541wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Pkao/laxSL1tBvyF2qyBYAFQHd6PJzhPTvVH60gf4qE=;
	b=UwJQAVVe5ja1TF5NjQuppvGF3v0E47s9bPNpyNasBtV8uoOzOoQpSfu7mpX7SgRF4/
	B8XqcTZHs3Z0Ud0VHFlIoOnj3kn42VXXIo0vT7n21nfkfZj8uwWl54RLY6fnulqNx3tg
	KPaRFrxpnyrgercC+VMPse5GXIUhIT6bWkYQxi+cM6G2FUyEgGD3QJAzUSq5sAdKLsfa
	YKYRK1KImrcnlzDyQ/p3jWGSXtx2nfm3oObSs7h5mXndXcDHiBAHOL59Tx1/ebYZE0dG
	euMsYUjdyUmINxm5dgdXBfkkHB/1dqsKB+B3iY7qYEM1dVH6D8Tec94LTJuHarc8Qmef
	MS7w==
X-Gm-Message-State: ALoCoQnTKFfGHm+VEYMe/vwmqSkxMkMvV8g4vfVNZjpVm34kWeMMzFiuhOiJ5CYgNNZpwhTpoXGV
X-Received: by 10.180.90.81 with SMTP id bu17mr46326076wib.35.1438700862564;
	Tue, 04 Aug 2015 08:07:42 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:41 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:11 +0100
Message-Id: <1438700831-26829-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
References: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 6/6] bitbake: toastergui: add action to empty "most built" recipes
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:44 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

It is not very good to just tell people: "this is empty because you
haven't done anything". We should politely invite them to do something
about it. Thus adding a "Choose a recipe to build" link to the all
compatible recipes page whenever the 'most built recipes' section is
empty.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index aad79b4..d21f4bd 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -68,6 +68,7 @@
 
       <div class="alert alert-info" style="display:none" id="no-most-built">
         <span class="lead">You haven't built any recipes yet</span>
+        <p style="margin-top: 10px;"><a href="{% url 'projecttargets' project.id %}">Choose a recipe to build</a></p>
       </div>
 
       <ul class="unstyled configuration-list" id="freq-build-list">
-- 
2.1.4


