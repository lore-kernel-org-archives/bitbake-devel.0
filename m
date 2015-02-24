Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id 52AB671633
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:04 +0000 (UTC)
Received: by pdev10 with SMTP id v10so34680770pde.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SLSK2FNEf3i/KIteuPz+aRzR8mh0PWJRAHXb+RIJjco=;
	b=LMC7RCPttPP7j+RN71Ame9e8onPG2RbX+A4xqyU7tqpwa0MeTQR+Wm4drgjGXBxiIU
	gcCa4dAP52ThrF8GNhT7IEZs7WizQsNVB4M9r7k/JNxsM4oJuMxS2bdnRz+YfMjzwyIZ
	MwNGMfgqOQA6wcsxgO62WJmbJ0RBIP2TajkmK1VcpHiv6s7dcjpopQzoGxlNjQFJB5nr
	IUp7mmXIZNAPlpcCF6mDmNSNyn728ZCKiJfqx06a8ve9ZCM8Hz0eKw0FWgEAHo4Goks9
	E9i/4XG48DmqrwM4sDdFErTDtSSIFrR6AAVCz4wCwFtI3mRONTcuIb4tmisKrhoWFjTL
	3c3Q==
X-Gm-Message-State: ALoCoQkLN8FG0Pt483BRm+7VdoZ/FRk4jIMQ/hPlcCfPWFngXZLMjHglmo52anHmnnIhGAmhjBpo
X-Received: by 10.66.102.4 with SMTP id fk4mr30309633pab.111.1424798465529;
	Tue, 24 Feb 2015 09:21:05 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id g7sm27565802pdm.4.2015.02.24.09.21.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:04 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 92BE35617FF; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:51 +0000
Message-Id: <b41ff87e628d274145f803a56ad02f24d9b3bfea.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 03/12] toaster: layerdetails Add link to machines file
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:04 -0000

From: Michael Wood <michael.g.wood@intel.com>

In the machines table for a layer add a link/icon to the machine
definition file.

[YOCTO #7241]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 6c803ff..49c62c6 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -396,7 +396,12 @@
                     <tbody>
                       {% for machine in machines %}
                       <tr>
-                        <td>{{machine.name}}</td>
+                        <td>
+                          {{machine.name}}
+                          {% if machine.get_vcs_machine_file_link_url %}
+                          <a href="{{machine.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a>
+                          {% endif %}
+                        </td>
                         <td>{{machine.description}}</td>
                         <td><button class="btn btn-block select-machine-btn" data-machine-name="{{machine.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %}}>Select machine</button></td>
                       </tr>
-- 
1.9.1


