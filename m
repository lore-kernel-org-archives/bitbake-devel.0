Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 9E5A6732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:00 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id lj1so35229686pab.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sfqXqpugKNH75LVKcyEzHHWPIAzxRSleTQ6APm25P78=;
	b=CgZRNf4DMCzZsaKYLF14ZT9Gq3/T0YwqMnC/XiZW2sNFqA8DmwDKlt1eQRr0o272+r
	CJOcxKb0v8ZEWy1RhBcu0Oy0p1pGE8B3TYERPFGxKzt3rR8V1P8KXImlo5Vof46hLlU5
	YxRSTsDt8VDWpMONKtScIEvBK20Q4nYGm7y5/LvIbZCuCCUTvCmcVr/77L7oDnt3derd
	k6FUXiB0j7IOQ6DuE6wBqmASm6iXrpKMFQBxSqzEb2zpRlvorZO0SHFMaTLZzakSVTG0
	TRAuA2nmqXBC3kLUlxji5tlCAO6LUnybtnCDOTAafgom9XL1LxgiiSNUnohHzFXNIh9Q
	wjmg==
X-Gm-Message-State: ALoCoQn9D/OfNP0j5jKyBA8+XdC7hjJoUSfssP+cFiZqSy2YrHkcOi7tdzKNVkW6xt46+p9Qi+LF
X-Received: by 10.70.37.4 with SMTP id u4mr31100415pdj.40.1423504921329;
	Mon, 09 Feb 2015 10:02:01 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gj9sm16971731pbc.32.2015.02.09.10.01.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:00 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 46DE456618A; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:31 +0000
Message-Id: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 01/27] toastergui: remove time link for failed build requests
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:04 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Failed build requests do not have a build time page where
you can look at the time spent on each task. Therefore,
their build time information cannot be a link to such
a page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/managed_mrb_section.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index d2ffdcd..c7ae6fd 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -100,7 +100,7 @@
             </div>
             <div class="lead ">
               <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
-                Build time: <a href="{% url 'buildrequestdetails' buildrequest.project.id buildrequest.pk %}">{{ buildrequest.get_duration|sectohms }}</a>
+                Build time: {{ buildrequest.get_duration|sectohms }}
               </span>
               <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}}, {{buildrequest.project.name|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
 
-- 
1.9.1


