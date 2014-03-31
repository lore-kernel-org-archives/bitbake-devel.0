Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id D5F496EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:17 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id bs8so3678980wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OnW7CdPoZ7R7iUn/gsdgcYw13kHp2WGyGDZH04CvH0E=;
	b=f1weSKIWDjSEtSg9o1OJQOeSSaJLBiYlz0vdvIj2yxY/IquKxnDvTkLeIGGV6I5RUY
	9qaPglI5Puij+5TguCOsDtmhFhX4vg96zCKHdgSWP70Mzoeu4hHVrh8r610CJSJeFBHh
	5pCOXx6uStnqOr5G5UQIkpYm3mGWSt3lgOtvuk3+MVrHh2cgaEVXBA2GZXoQ01OAwHRb
	xn6qvgTjxK4WRzvXtWu/n9KrQtU9NDu3VEofQP3ixRx12VkNaiWOUtCIGspJwKbYSpj/
	n+meuQZEkPcDSRXgvdlalmUTVeXuXLZ86ucvSw11br3IbPGkJ4s+gJfLb2oqaEaZ3vcw
	BLoA==
X-Gm-Message-State: ALoCoQmIXYpjj5V40eWsfx/zofEJNRMRjMOoB4uT47L4Ygat1izbeEgTqgUBvHFR4o1j2Tp/TK/U
X-Received: by 10.180.189.169 with SMTP id gj9mr13736816wic.17.1396284438183; 
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm27645771wib.8.2014.03.31.09.47.15
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 133C05603A6; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:07 +0100
Message-Id: <9f2c13bae1f892db529d56b9539483a5a5c86979.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 07/14] toaster: Remove trailing spaces from 'name'
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

From: Belen Barros Pena <belen.barros.pena@intel.com>

Remove all trailing spaces from 'name' because they show up
in the filter headings, which I find incredibly annoying.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6413c80..6028d4d 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1111,13 +1111,13 @@ def configvars(request, build_id):
                 'search_term':search_term,
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
-                {'name': 'Variable ',
+                {'name': 'Variable',
                  'qhelp': "BitBake is a generic task executor that considers a list of tasks with dependencies and handles metadata that consists of variables in a certain format that get passed to the tasks",
                  'dclass' : "span3",
                  'orderfield': _get_toggle_order(request, "variable_name"),
                  'ordericon':_get_toggle_order_icon(request, "variable_name"),
                 },
-                {'name': 'Value ',
+                {'name': 'Value',
                  'qhelp': "The value assigned to the variable",
                  'dclass': "span4",
                 },
@@ -1137,7 +1137,7 @@ def configvars(request, build_id):
                                ]
                              },
                 },
-                {'name': 'Description ',
+                {'name': 'Description',
                  'qhelp': "A brief explanation of the variable",
                  'clclass': 'description', 'hidden' : 0,
                  'dclass': "span5",
-- 
1.9.1


