Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 3C7296FB0B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:33 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id hr14so1232586wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=90ZCpU9dl6ksH65AIB94W6deLyAP65imBie0cpJEJvQ=;
	b=Om70n7EPmpIBimQAoCbmMCroWeYS8HfJ13DzgvYtPoK2le7fWdA7z5Y+hT5CTfaATz
	Y+dPSaFtt8Ps2RIo7vU0N73o4yY8Sj/gS3Wh8qTt/IfvBFlx9F3pHpDMEGU67VueoPOe
	UsY9S7DXhMJjaUTNoQdFoP3glO9NqpHqMm/Wy9duA3xx4601wSjYB4AeSTE8UhKHvpSh
	QTU8+k/tqV23Uvv3qOm7vnMEixZHCwUdhxnRVcirqikT8JpGXuqu977DV1GqANhsGns8
	evFfBMOFoycbusZnQCKRapjglg1+a6btpSvhniWR4qOSst/hLPdfjiWXufVTQUN4jtL1
	/few==
X-Gm-Message-State: ALoCoQnXA3HTtn55ESWxLvHeFmZSzVfflMIdHRilGwJnINN3PKRsJA5cU0bhDsB5ZlRg/YGShzJ+
X-Received: by 10.180.87.164 with SMTP id az4mr17807468wib.2.1395686254524;
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n15sm41547398wij.3.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id BBDD3561362; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:18 +0000
Message-Id: <0047dd486c23707dd0fd7f9a2ae485b987d0b3e3.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Subject: [PATCH 08/18] toaster: Update local configuration counter
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:36 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The counter for the local configuration filter in the
variables table was counting only variables set by
local.conf. Updating to add in variables set by
bblayers.conf

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2156d68..732be8f 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1072,7 +1072,7 @@ def configvars(request, build_id):
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
                     'options' : [
-                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__contains='conf/local.conf').count(), 'Select this filter to see variables set by the <code>local.conf</code> and <code>bblayers.conf</code> configuration files inside the <code>/build/conf/</code> directory'),
+                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__regex='conf/(local|bblayers).conf').count(), 'Select this filter to see variables set by the <code>local.conf</code> and <code>bblayers.conf</code> configuration files inside the <code>/build/conf/</code> directory'),
                                ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/',queryset_with_search.filter(vhistory__file_name__contains='conf/machine').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/machine/</code> directory'),
                                ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/',queryset_with_search.filter(vhistory__file_name__contains='conf/distro').count(), 'Select this filter to see variables set by the configuration file(s) inside your layers <code>/conf/distro/</code> directory'),
                                ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf',queryset_with_search.filter(vhistory__file_name__contains='conf/layer.conf').count(), 'Select this filter to see variables set by the <code>layer.conf</code> configuration file inside your layers'),
-- 
1.8.3.2


