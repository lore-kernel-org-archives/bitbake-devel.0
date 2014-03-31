Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id F31306F8DF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:15 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so3672771wib.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FfRTFd9dlopqOrfFBxaR2JXHsYFIQk6evKq18sthpeU=;
	b=BfIVIJO6jCpYJre1ptzeIgtOoS3jfZ6PHmzWAFySjS20861L1kzyVTi+JecQcW5kN+
	oyIbH972oGHyDDmOa8B3bBjdowV/xtk542ogvM8jLN0doCgk1SOZ+w5UDiMUWzRdDFns
	u0C0fOkjCMiWjuQApE2Eykelp16GK9/FmwXQgRSuSkC+wdGwjHMtBDhB/bm4QmdsLcKZ
	Q4JvO4KykMhywNXjVOh8wz1E65Qu7G4dnkzMfkC45lmwFj0Om+jLYuIcUWtsswDuRGCx
	cLqEAzSjHfBtqddYTb+mM1r6XFHbt7uxJAouKJ1IAZNPRa1nEPP1eeJk0YjMMJ6zuoWX
	vrww==
X-Gm-Message-State: ALoCoQnGXJS054l4MfXVrl4+nHGWPV/yts8I/1rTM/XWw+ug/F7c6oLuD2imBT+bYXi/tbbJbZD/
X-Received: by 10.180.101.134 with SMTP id fg6mr13731097wib.6.1396284436295;
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm27645608wib.8.2014.03.31.09.47.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0F8FB56038C; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:05 +0100
Message-Id: <edbffe6dbd1c1c2532cdcd4945982c7f7104179e.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 05/14] toaster: disable configvar sorts for value and files
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:18 -0000

From: David Reyna <David.Reyna@windriver.com>

Disable the sort on files because it sorts on the file array's
first (and invisible) element. Disable the sort on values
because the raw ASCII sort looks wrong to the general user,
especially for values with leading spaces.

[YOCTO #6004]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4e412ca..6413c80 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1120,15 +1120,11 @@ def configvars(request, build_id):
                 {'name': 'Value ',
                  'qhelp': "The value assigned to the variable",
                  'dclass': "span4",
-                 'orderfield': _get_toggle_order(request, "variable_value"),
-                 'ordericon':_get_toggle_order_icon(request, "variable_value"),
                 },
                 {'name': 'Set in file',
                  'qhelp': "The last configuration file that touched the variable value",
                  'clclass': 'file', 'hidden' : 0,
                  'dclass': "span6",
-                 'orderfield': _get_toggle_order(request, "vhistory__file_name"),
-                 'ordericon':_get_toggle_order_icon(request, "vhistory__file_name"),
                  'filter' : {
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
-- 
1.9.1


