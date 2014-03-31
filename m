Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 8F38A6F8DA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:17 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id z2so1924225wiv.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vS/RpWMyUoNHZAlyZuiYjJNBkGJhA0iY0RcNtHn4jmM=;
	b=SuRB+0aJqa/oB0GjZqGuNhbXToBMlMj/VUCpi5gdif3i9r2nVVw4UVVwJROylYajm8
	R+cLr89pJ8p2Qcp9asRWm4gRW6kH2IaiAegYw+oHUotf71dZAhHPqboPwtL//CHecNn9
	OhsGfK2X/++DyIZHTRtOohblw89EGApMsmS4d6Hqv2YBzaGfeD8xBnEdD1a6XwIAIy/M
	PC41oj5euYsmLf1M44xgo3hGb23guWgXMMGTTDpTM15XgCfVdcWVrdfkq9Sqj+y3+2h2
	3eh36f2CZtR2KZIL2FmIXI3lY+89F8/BXFDVpVLxvBM4kajgro2VTjVZcPQdodPu2UTe
	edUg==
X-Gm-Message-State: ALoCoQnJF84NgSzjr+0rSitSMy6xfdtrnXVSTsJIrT1eZYIXb23N4KFbFUPyrUdvdAhjXNMtTdej
X-Received: by 10.180.100.169 with SMTP id ez9mr13780387wib.15.1396284437779; 
	Mon, 31 Mar 2014 09:47:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm27645795wib.8.2014.03.31.09.47.15
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 16D5C5603C9; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:09 +0100
Message-Id: <a2e43f0197129290f52b3a12b4c8839aa181090e.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 09/14] toaster: Fix the fade out animation
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:17 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Apply the animation to any element with the class
.highlight

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 260f5d4..69e8cad 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -46,8 +46,7 @@ dd p { line-height: 20px; }
 .details { margin-top: 30px; }
 
 /* Required classes for the highlight behaviour in tables */
-.highlight { background-color: #D9EDF7; }
-.flash:target { -webkit-animation: target-fade 7s 1; -moz-animation: target-fade 7s 1; animation: target-fade 7s 1; }
+.highlight { -webkit-animation: target-fade 7s 1; -moz-animation: target-fade 7s 1; animation: target-fade 7s 1; }
 @-webkit-keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
 @-moz-keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
 @keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
-- 
1.9.1


