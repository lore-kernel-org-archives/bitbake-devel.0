Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED5C5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15782.1786721771470651839
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 08:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=O2fu98MH;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 889513D8185E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 11:36:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 9xljp5a8teHL; Fri, 14 Aug 2026 11:36:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4AC213D818B5;
	Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4AC213D818B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786721768; bh=tsoPw+pvdQM1mJ8+hKpGH3S1RnNdrd6GL2U2MESIiIc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=O2fu98MH1OM6KMxuHQlMZfwFsN6BQgssNiREOxxsjJkHsDkbqcndZvz+ALbJbMK1b
	 kXnekCqETIvU7gC1VqTraCD5POi/PqF0y2rqsngGgBDIBCJH2AawWZuoevK71nH+ZU
	 uoGI9+eapnKkpeKcLxNk70M/wn8MpqlAh76EyeEXFq9D5XB1ODt3Y6JzVW9AgkbwIm
	 rRY3TVAQjvwpNPhXWlUuX0xYUNhU9SEPLRvnep77e0gJUnDDWVzkgFQlU+S1UsY/va
	 2nfrTPFc5Re79XpJauMSeqXIWaxTANe0OdcKOTxIZ/z4Zdh59N94f5jR9YNvv6fa+6
	 YGBRBCebxyEVA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id X4xlCnYJ3zE3; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EFFDD3D818D3;
	Fri, 14 Aug 2026 11:36:07 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH v2 4/5] toaster: Generalize detail table controls
Date: Fri, 14 Aug 2026 11:35:57 -0400
Message-ID: <20260814153602.2107764-5-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
References: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19941

Allow detail tables to provide their validated page size and default
ordering while preserving existing defaults for current users.

AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
---
 .../toastergui/templates/detail_pagination_bottom.html        | 4 ++--
 lib/toaster/toastergui/templates/detail_search_header.html    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/detail_pagination_bottom.ht=
ml b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
index 15adfbc91..ddcba133e 100644
--- a/lib/toaster/toastergui/templates/detail_pagination_bottom.html
+++ b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
@@ -41,8 +41,8 @@
 <script>
  $(document).ready(function() {
     // load data for number of entries to be displayed on page
-    if ({{request.GET.count}} !=3D "") {
-      pagesize =3D {{request.GET.count}};
+    if ({{validated_pagesize|default:request.GET.count}} !=3D "") {
+      pagesize =3D {{validated_pagesize|default:request.GET.count}};
     }
     $('.pagesize option').prop('selected', false)
                          .filter('[value=3D"' + pagesize + '"]')
diff --git a/lib/toaster/toastergui/templates/detail_search_header.html b=
/lib/toaster/toastergui/templates/detail_search_header.html
index 7a9865908..0205b88f6 100644
--- a/lib/toaster/toastergui/templates/detail_search_header.html
+++ b/lib/toaster/toastergui/templates/detail_search_header.html
@@ -31,7 +31,7 @@ $(document).ready(function() {
         <div class=3D"form-group">
           <div class=3D"btn-group">
             <input id=3D"search" class=3D"form-control" type=3D"text" pl=
aceholder=3D"Search {{search_what}}" name=3D"search" value=3D"{% if reque=
st.GET.search %}{{request.GET.search}}{% endif %}">
-            <input type=3D"hidden" value=3D"name:+" name=3D"orderby">
+            <input type=3D"hidden" value=3D"{{search_orderby|default:'na=
me:+'}}" name=3D"orderby">
             <input type=3D"hidden" value=3D"l" name=3D"page">
             {% if request.GET.search %}
             <span class=3D"remove-search-btn-detail-search search-clear =
glyphicon glyphicon-remove-circle"></span>
--=20
2.55.0


