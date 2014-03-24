Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 6BF236F77C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:31 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id x12so3651714wgg.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8F5Qu76lo+9KYxV3EwSOtaaI+bZCxvH5+Ix2fXPJyHI=;
	b=AnChC0/FAldWeoxOmOVH1vnsh2ai5FZJ2XZsq75nq6GTD54WklD7B6FYEWMpA9B5V2
	A64UNlxkV2rHDQplBhgHA/WTkrjGQVlaSUexMaUf/xKsFFa9tV7pt8LoAVw0YhN/64hl
	STP6HC1Oe5V7Z00csjCC8UEVV2VSXCBJabhqlk8V8z4fHPe3b1YfPTD1LjxhYJWp3Wqw
	Gkje8NCd7tR2RCpQuMd7X7FJCDE6caYJoQefW4ifVmMqzDvy6KIIBn+sBQqAwV/45zN3
	ZBJj2iOr6McWhcINcPDpgN6Xtt3rVQQKnFyNumPNxuEdC69TY9PTJADAvMnBXsdKHe0f
	C9NA==
X-Gm-Message-State: ALoCoQnMXxVsID4XfVwe6G36RkZdsgkbh9PRqkzjV9sihdW0+lahSYOo/Vt7iApWEPMyJ46rBvTS
X-Received: by 10.180.89.102 with SMTP id bn6mr17820676wib.28.1395686252496;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id jd2sm41561581wic.9.2014.03.24.11.37.31
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B298D56100C; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:13 +0000
Message-Id: <b80c578d9330a45e9c2502701de2ebb6307b1caf.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 03/18] toaster: reset default filter for configvar page on new searches
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:32 -0000

From: David Reyna <David.Reyna@windriver.com>

The configvar page has a default filter by design. However, new search terms
should override and clear that filter, for consistency across the interface.

[YOCTO #5961]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 97514cc..eaa6cf8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1010,10 +1010,13 @@ def configvars(request, build_id):
     template = 'configvars.html'
     mandatory_parameters = { 'count': 100,  'page' : 1, 'orderby':'variable_name:+', 'filter':'description__regex:.+'};
     retval = _verify_parameters( request.GET, mandatory_parameters )
+    (filter_string, search_term, ordering_string) = _search_tuple(request, Variable)
     if retval:
+        # if new search, clear the default filter
+        if search_term and len(search_term):
+            mandatory_parameters['filter']=''
         return _redirect_parameters( 'configvars', request.GET, mandatory_parameters, build_id = build_id)
 
-    (filter_string, search_term, ordering_string) = _search_tuple(request, Variable)
     queryset = Variable.objects.filter(build=build_id).exclude(variable_name__istartswith='B_').exclude(variable_name__istartswith='do_')
     queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string).distinct().exclude(variable_value='',vhistory__file_name__isnull=True)
     queryset = _get_queryset(Variable, queryset, filter_string, search_term, ordering_string)
-- 
1.8.3.2


