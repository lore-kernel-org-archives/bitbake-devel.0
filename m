Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id A1B5A76541
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:40 +0000 (UTC)
Received: by wibxm9 with SMTP id xm9so170707845wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iuxaxcvleTMP3eiN8Q+GKsuPP4Tuh2Hc4y01VhTWbmw=;
	b=IJbrd7DCGwNw2rG3QttpG2yyCQkXudBlXrdE0RdjufHUNDEzKOvE19QSVzLAXnXkMn
	/8qmhUyBNh21TGjK1DK9DEAXuy053jeP94jecABqgZ7zPllPcmhHxymb46eKo2hW0sO2
	MAKGla6bdaax9B2v3Bl9DJV3gUS/XawHuNTDSoKiofLozMpXGlcSyCd0odFkT3no9wAu
	3ML5xxhZTIsyF4vPTmlqukzz2XsvmFDXO2UpIDl6J6mflHBhs1SJkNm7TWnQfZvnGHBH
	k/TMoluBp20ppCZjfRZiiBs4TZTC0WV6H2JOjQQ+SwqEa0vJFLritGLGSBNFJ8ElXiIs
	061w==
X-Gm-Message-State: ALoCoQlcCYTfRNvfXdlQGB60tsHITNYZOFBBGvJpM7ZjEer19ZsjxWNx/gOXJ3WWeKmzPWbICRK0
X-Received: by 10.180.21.169 with SMTP id w9mr46847364wie.73.1438700860229;
	Tue, 04 Aug 2015 08:07:40 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:39 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:08 +0100
Message-Id: <1438700831-26829-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
References: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/6] bitbake: toastergui: change link styles in alert-info
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:41 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make them a bit less bold: it was a bit in your face
before.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index dbe2307..e252dc1 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -35,7 +35,7 @@ dd code, .alert code { white-space: pre-wrap; word-break: break-all; word-wrap:
 .alert-error code { background-color: transparent; border: none; color: #B94A48; margin-bottom:0px; }
 .alert-error pre { background-color: transparent; border: none; color: #B94A48; word-break: normal; margin-bottom: 0px; }
 .alert-warning pre { word-break: normal; }
-.alert-info a { font-weight: bold; }
+.alert-info a { font-weight: 300; }
 .alert-info code { color: #3A87AD; }
 .tooltip code { background-color: transparent; color: #FFFFFF; font-weight: normal; border: none; font-size: 1em; }
 
-- 
2.1.4


