Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id F2CB572CC9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:19 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id a1so19300328wgh.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=xNGPdZAK9MOVUpCoeBA/rAHx8+lYJw+0XuTRKU4Yv/A=;
	b=k367PvvWc/jl92l4V3vzHWH3vz28+KIbKroDc2KlTlw3YROoBNSOc0/PRax8dyf4sl
	9OUU3BoNAEV2rbqNZCY68k54a+iveB2V7jTndPmI4D2MhKir0/4McLLOpR6OBVLTAQuR
	VSZn97yMwybJ+XAN/Vuyhfc+U0ODBGdM2ylx2gcU+QcxxJnhmwoez9O4DyT73HD9Zljm
	OtBPPlcoZs7wuVkiftVZcWp7Y95oyNN31B7z3cjUak2vNFRbNQHniRjn2bSMMufaGnF8
	P8aVzYSfplVEZZCvIernPpWlsEJTxok6ITz7XoxNf1lSnbmbiBhdz9ZZvxjtFcRyEL1F
	dGQQ==
X-Gm-Message-State: ALoCoQlxShjdoZJ3XPW4536Tc7k0W94XpyyxeAQ/qJamovMLWfR4gzLSVdCY3PeRXcTyGTtrfqTK
X-Received: by 10.181.9.107 with SMTP id dr11mr59903439wid.22.1421864539353;
	Wed, 21 Jan 2015 10:22:19 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fp2sm8297817wib.8.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E463856404A; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:33 +0000
Message-Id: <57577d3532d949ba993ac0eccec3e315da4b3b5c.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/12] toastergui: fix duplicate IDs all builds page
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the duplicate IDs found in the all builds page,
originating in the "Project" column filter.

Also fix misspell "Log1" instead of "Log".

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4d00fbd..7a11bbd 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1725,10 +1725,10 @@ if toastermain.settings.MANAGED:
             return _redirect_parameters( builds, request.GET, e.response)
 
         context['tablecols'].append(
-                    {'name': 'Project', 'clclass': 'project',
+                    {'name': 'Project', 'clclass': 'projectx',
                      'filter': {'class': 'project',
                             'label': 'Project:',
-                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
+                            'options':  map(lambda x: (x.name,'project:%d' % x.id,x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
 
                            }
                     }
@@ -3152,6 +3152,14 @@ else:
                                              ]
                                 }
                     },
+                    {'name': 'Log',
+                     'dclass': "span4",
+                     'qhelp': "Path to the build main log file",
+                     'clclass': 'log', 'hidden': 1,
+                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
+                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                     'orderkey' : 'cooker_log_path',
+                    },
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
                      'orderfield': _get_toggle_order(request, "timespent", True),
@@ -3165,31 +3173,6 @@ else:
                     ]
                 }
 
-        if not toastermain.settings.MANAGED:
-            context['tablecols'].insert(-2,
-                    {'name': 'Log1',
-                     'dclass': "span4",
-                     'qhelp': "Path to the build main log file",
-                     'clclass': 'log', 'hidden': 1,
-                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                     'orderkey' : 'cooker_log_path',
-                    }
-            )
-
-
-        if toastermain.settings.MANAGED:
-            context['tablecols'].append(
-                    {'name': 'Project', 'clclass': 'project',
-                     'filter': {'class': 'project',
-                            'label': 'Project:',
-                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=Build.IN_PROGRESS).count()), Project.objects.all()),
-
-                           }
-                    }
-            )
-
-
         response = render(request, template, context)
         _save_parameters_cookies(response, pagesize, orderby, request)
         return response
-- 
1.9.1


