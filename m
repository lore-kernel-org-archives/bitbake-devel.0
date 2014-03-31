Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174])
	by mail.openembedded.org (Postfix) with ESMTP id 016106EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:19 +0000 (UTC)
Received: by mail-we0-f174.google.com with SMTP id t60so5121503wes.33
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=57/UiyQVeUG9m2dk0GPmi/G/OmBgW7L90sEEZbIngfc=;
	b=fiofEvxxim05nAScTh6RmCnGI6BWPBIrFr3dwaanqpXBUv7JpGakE97UVVlIONlG60
	UIeHs5DS2q8W3F3Y8Rhvj+bt185+RuANUfnh3xj6T/ISvv2FLdB0VRYYF88hNcczg8Ko
	8LglvH1m12AmZea7vuOfc8ZjcYi6YYqWXBn7aMYIkTl+G8ofg69MAYoPw489t0+V2zW/
	fko2ZZuME59p53kLUFjdEsSq7AMgjtF8as+2Zsdpvrlwt/8LrP3XPz8WGFfiydmzJACY
	wCHUp9FjkyBbo03/TUEBAAQNzsqoCfsX3duzBxJdPerq4WOgy9+tVIlq5XrKTJIC9T9C
	xdKw==
X-Gm-Message-State: ALoCoQne4L9AL1WdlBHZP/8Ph/omD1qXXex24owQaLSrbQqSQjaTibiP8uln0jFx/nwQ6/vsbOfu
X-Received: by 10.194.85.19 with SMTP id d19mr4463531wjz.96.1396284439833;
	Mon, 31 Mar 2014 09:47:19 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gn1sm27627975wib.14.2014.03.31.09.47.16 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:17 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 18944560404; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:10 +0100
Message-Id: <df8a206b3a00d95282b0b9cb6b2b1bd57666c889.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 10/14] toaster: Increase animation duration
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:20 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Increase the duration of the blue highlight animation
from 7 to 10 seconds.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 69e8cad..0b53718 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -46,7 +46,7 @@ dd p { line-height: 20px; }
 .details { margin-top: 30px; }
 
 /* Required classes for the highlight behaviour in tables */
-.highlight { -webkit-animation: target-fade 7s 1; -moz-animation: target-fade 7s 1; animation: target-fade 7s 1; }
+.highlight { -webkit-animation: target-fade 10s 1; -moz-animation: target-fade 10s 1; animation: target-fade 10s 1; }
 @-webkit-keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
 @-moz-keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
 @keyframes target-fade { 0% { background-color: #D9EDF7; } 25% { background-color: #D9EDF7; } 100% { background-color: white; } }
-- 
1.9.1


