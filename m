Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 92A1C72B3D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 13:15:25 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id r20so3170940wiv.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 Jan 2015 05:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=gpyRN5ag+DZvm5Fmy++1a2R3hAwLS9Wvaj/qXI/aStg=;
	b=LKmIo3R8KGoWxchmWZ8WjF9u4JV9u4bAhNFXSH9Gy4JClH7uzzkaFbda+2+4Xi7jAD
	qQG4XMNAFrth2XyuG7j7fagFaw8AHN2/U3/rZ/sl2dJiU6uDOgBdCQoSt0keayoTQojw
	ZQrHrioWPtX+xfrDrx31SKK0ZNM0lMJ43khtLw7fZKPmES9b3U9TYrOKK15/j+SgneSL
	jrh4mdmKnX/U8A5jdiKUG83yENMES/vDjAgZDY0KY6BElsGjqcMgSABocWZrfuu08UQ5
	CxsJfxe0/DA1QE4j7ifS4vhtwnAD0zIyS/KNNmVJcT9KvoPpNm40sTgTa0C2LYccMeJB
	ifmQ==
X-Gm-Message-State: ALoCoQl3ncHngnoaJsozhMKuoc9Gw/odxgdmy4ekqdt+Zgf7EpOliT5Y7i4mQ+FncDhCl32joojP
X-Received: by 10.180.206.165 with SMTP id lp5mr19421732wic.83.1420722925390; 
	Thu, 08 Jan 2015 05:15:25 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n5sm6562404wic.6.2015.01.08.05.15.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jan 2015 05:15:24 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0B2F75622FB; Thu,  8 Jan 2015 13:15:16 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Jan 2015 13:15:12 +0000
Message-Id: <77f0472587b761287b9247c95ebdba5514a2a577.1420722767.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
References: <8491ee5e1257241da9b274d48e13674be95da84e.1420722767.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1420722767.git.alexandru.damian@intel.com>
References: <cover.1420722767.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/5] toaster: do not launch web browser on noweb option
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
X-List-Received-Date: Thu, 08 Jan 2015 13:15:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch makes Toaster managed mode obey the "noweb" parameter
by not starting the web server and launching the web browser
command if the "noweb" parameter is specified.

The web browser will be pointed at 127.0.0.1 instead of 0.0.0.0

[YOCTO #7039]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6969bf7..a6d2e92 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -185,11 +185,14 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     }
     TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
-    if ! webserverStartAll; then
+    if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
         echo "Failed to start the web server, stopping" 1>&2;
         exit 1;
     fi
-    xdg-open http://0.0.0.0:$WEB_PORT/ >/dev/null 2>&1 &
+    if [ $WEBSERVER -gt 0 ]; then
+        echo "Starting browser..."
+        xdg-open http://127.0.0.1:$WEB_PORT/ >/dev/null 2>&1 &
+    fi
     trap trap_ctrlc SIGINT
     echo "Running. Stop with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
-- 
1.9.1


