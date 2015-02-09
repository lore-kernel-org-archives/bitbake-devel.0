Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 9478C732AF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:07 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id lj1so35251542pab.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=s9aJrYi0iptSTMRU3SeMJK8t5Ijd6lrin+CDQEsVdvc=;
	b=W6fbksWmsr0uLwNBkL4XOOrb0jgV5fY/19MPjbr4X/FJ17WR76gemC7UMX1+dQKTqK
	mrpkJBhBoGRi7mRprhzzqlEZV82VeSJbdqfoNPZH6Mlo6Z5ZOF/TX/a7rCD0EUXpJQWL
	706b0qkZClfnYCq9JDcLryIbllqZLUFYFfrh/uFdXfMqlU0JJKi25omPv+UmMvNjZA6v
	Sk7wW9HKrArA8im/JCOw9Rb1qCW8gKoURIjCQFHxvzqxY3CvxQ4+Jc+Q3I2dovlJbDFE
	JejYNqiLjPtXby04rVCeXNFkYrzEcvohEVsipUAND+Nz7gN6jXQzQ3a9FtAqXgoYBzmj
	wX+Q==
X-Gm-Message-State: ALoCoQkeFd0IA0c+d9/Rm3PvVRoxGIGVEvqugeiQYNKt1Sn3cptmmf05P66peETdbLe7Ws7UYUb2
X-Received: by 10.66.193.33 with SMTP id hl1mr30980942pac.141.1423504928499;
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	xl10sm10833476pab.8.2015.02.09.10.02.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 55E4D56619E; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:40 +0000
Message-Id: <102144f8e5069f76e7de8db052c3c4531609771f.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 10/27] toastergui: set column heading to 'Revision'
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:07 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Replace the column heading 'Branch, tag or commit' with
'Revision'. This also fixes 7023.

[YOCTO #7023]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html |  5 ++++-
 lib/toaster/toastergui/views.py                    | 10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 4ffd071..6705215 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -142,7 +142,10 @@
                   <i id="change-subdir" class="icon-pencil"></i>
                   <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
                 </dd>
-                <dt>Brach, tag or commit</dt>
+                <dt>
+                  <i class="icon-question-sign get-help" title="The Git branch, tag or commit"></i>
+                  Revision
+                </dt>
                 <dd>
                   <span class="current-value">{{layerversion.commit}}</span>
                   <form style="display:none;">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4b770ff..9567e62 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2574,9 +2574,9 @@ if toastermain.settings.MANAGED:
                     'hidden': 1,
                     'qhelp': "The layer directory within the Git repository",
                 },
-                {   'name': 'Branch, tag o commit',
+                {   'name': 'Revision',
                     'clclass': 'branch',
-                    'qhelp': "The Git branch of the layer. For the layers from the OpenEmbedded source, the branch matches the Yocto Project version you selected for this project",
+                    'qhelp': "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
                 },
                 {   'name': 'Dependencies',
                     'clclass': 'dependencies',
@@ -2740,8 +2740,9 @@ if toastermain.settings.MANAGED:
                         'options': map(lambda x: ("Targets provided by " + x.name + " layers", 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
                     }
                 },
-                {   'name': 'Branch, tag or commit',
+                {   'name': 'Revision',
                     'clclass': 'branch',
+                    'qhelp': "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project.",
                     'hidden': 1,
                 },
             ]
@@ -2827,8 +2828,9 @@ if toastermain.settings.MANAGED:
                         'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
                     }
                 },
-                {   'name': 'Branch, tag or commit',
+                {   'name': 'Revision',
                     'clclass': 'branch',
+                    'qhelp' : "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
                     'hidden': 1,
                 },
                 {   'name': 'Select',
-- 
1.9.1


