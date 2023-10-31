Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C236C4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:24:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.187705.1698762261492106885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:24:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=G1Yv7xDE;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D3BD29C0C3C;
	Tue, 31 Oct 2023 10:24:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4BZl4GLeBt_t; Tue, 31 Oct 2023 10:24:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8B0F29C2CD7;
	Tue, 31 Oct 2023 10:24:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8B0F29C2CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698762258; bh=tXgvqcpS8oEsRMHXsbeVzGAVwGdTfUNIsrrm/qEUWbk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=G1Yv7xDEum20bP5xaHDukAT7mY5lhfUTkCRkqjdhIJ6KsBNEzbTlBWhojfbIYEd9t
	 /ViWQkaN/uvxcyfSTX8JcrFUlf3RPjKSpHQ208ViudxNl5PpGNuweXjgCKUnOYCbxL
	 ByvzCedieZHd0t8cVZ4dBdb/ORC9rl7wq3id9098CsGPGvnExQNUIYyHNsCiwmz+9x
	 bsFEAySXYGCBjsrP/L/k88XgrU74QRGsyWsnft1bYh7j340iRNMPkM0ig3ftySeNTy
	 umtl1iIKnWh1ZCXex0gCqjtUie6WjJ+3EK0E2bGIGKi+vDxNXl9+yckzU1tJUiJnpC
	 V7Z6uHQLfk2KQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WCeO-ECS-CAU; Tue, 31 Oct 2023 10:24:18 -0400 (EDT)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 648589C0C3C;
	Tue, 31 Oct 2023 10:24:18 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] toaster: replace deprecated tags ifequal and ifnotequal
Date: Tue, 31 Oct 2023 10:24:16 -0400
Message-Id: <20231031142416.19499-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:24:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15338

Tags ifequal and ifnotequal are deprecated and were removed on version 3.=
1
https://django.readthedocs.io/en/stable/releases/3.1.html#deprecated-feat=
ures-3-1

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 .../toastergui/templates/package_built_dependencies.html  | 8 ++++----
 .../templates/package_included_dependencies.html          | 8 ++++----
 .../templates/package_included_reverse_dependencies.html  | 4 ++--
 bitbake/lib/toaster/toastergui/templates/recipe.html      | 4 ++--
 bitbake/lib/toaster/toastergui/templates/target.html      | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/package_built_depen=
dencies.html b/bitbake/lib/toaster/toastergui/templates/package_built_dep=
endencies.html
index a5d5893571..2493954deb 100644
--- a/bitbake/lib/toaster/toastergui/templates/package_built_dependencies=
.html
+++ b/bitbake/lib/toaster/toastergui/templates/package_built_dependencies=
.html
@@ -18,7 +18,7 @@
         </ul>
         <div class=3D"tab-content">
             <div class=3D"tab-pane active" id=3D"dependencies">
-            {% ifequal runtime_deps|length 0 %}
+            {% if runtime_deps|length =3D=3D 0 %}
                 <div class=3D"alert alert-info">
                     <strong>{{package.fullpackagespec}}</strong> has no =
runtime dependencies.
                 </div>
@@ -54,8 +54,8 @@
 						{% endfor %}
                     </tbody>
                 </table>
-            {% endifequal %}
-            {% ifnotequal other_deps|length 0 %}
+            {% endif %}
+            {% if other_deps|length !=3D 0 %}
                 <h3>Other runtime relationships</h3>
                 <table class=3D"table table-bordered table-hover">
                     <thead>
@@ -93,7 +93,7 @@
                     	{% endfor %}
                     </tbody>
                 </table>
-                {% endifnotequal %}
+                {% endif %}
             </div> <!-- tab-pane -->
         </div> <!-- tab-content -->
 {% endblock tabcontent %}
diff --git a/bitbake/lib/toaster/toastergui/templates/package_included_de=
pendencies.html b/bitbake/lib/toaster/toastergui/templates/package_includ=
ed_dependencies.html
index 95e56ded26..1f5ed6d913 100644
--- a/bitbake/lib/toaster/toastergui/templates/package_included_dependenc=
ies.html
+++ b/bitbake/lib/toaster/toastergui/templates/package_included_dependenc=
ies.html
@@ -14,7 +14,7 @@
     {% include "package_included_tabs.html" with active_tab=3D"dependenc=
ies" %}
     <div class=3D"tab-content">
        <div class=3D"tab-pane active" id=3D"dependencies">
-       {% ifnotequal runtime_deps|length 0 %}
+       {% if runtime_deps|length !=3D 0 %}
             <table class=3D"table table-bordered table-hover">
                 <thead>
                     <tr>
@@ -48,9 +48,9 @@
             <div class=3D"alert alert-info">
                 <strong>{{package.fullpackagespec}}</strong> has no runt=
ime dependencies.
             </div>
-        {% endifnotequal %}
+        {% endif %}
=20
-        {% ifnotequal other_deps|length 0 %}
+        {% if other_deps|length !=3D 0 %}
             <h3>Other runtime relationships</h3>
             <table class=3D"table table-bordered table-hover">
                 <thead>
@@ -103,7 +103,7 @@
                         {% endfor %}
                 </tbody>
             </table>
-        {% endifnotequal %}
+        {% endif %}
         </div> <!-- end tab-pane -->
     </div> <!-- end tab content -->
     {% endwith %}
diff --git a/bitbake/lib/toaster/toastergui/templates/package_included_re=
verse_dependencies.html b/bitbake/lib/toaster/toastergui/templates/packag=
e_included_reverse_dependencies.html
index fb310c7fc7..dae4549e21 100644
--- a/bitbake/lib/toaster/toastergui/templates/package_included_reverse_d=
ependencies.html
+++ b/bitbake/lib/toaster/toastergui/templates/package_included_reverse_d=
ependencies.html
@@ -15,7 +15,7 @@
     <div class=3D"tab-content">
         <div class=3D"tab-pane active" id=3D"brought-in-by">
=20
-        {% ifequal reverse_count 0 %}
+        {% if reverse_count =3D=3D 0 %}
            <div class=3D"alert alert-info">
                 <strong>{{package.fullpackagespec}}</strong> has no reve=
rse runtime dependencies.
             </div>
@@ -43,7 +43,7 @@
 					{% endfor %}
                 </tbody>
             </table>
-        {% endifequal %}
+        {% endif %}
         </div> <!-- end tab-pane -->
     </div> <!-- end tab content -->
     {% endwith %}
diff --git a/bitbake/lib/toaster/toastergui/templates/recipe.html b/bitba=
ke/lib/toaster/toastergui/templates/recipe.html
index 3f76e656fe..4b5301b548 100644
--- a/bitbake/lib/toaster/toastergui/templates/recipe.html
+++ b/bitbake/lib/toaster/toastergui/templates/recipe.html
@@ -186,9 +186,9 @@
                         <i class=3D"icon-question-sign get-help hover-he=
lp" title=3D"{{task.get_outcome_help}}"></i>
                     </td>
                     <td>
-                        {% ifnotequal task.sstate_result task.SSTATE_NA =
%}
+                        {% if task.sstate_result !=3D task.SSTATE_NA %}
                             {{task.get_sstate_result_display}}
-                        {% endifnotequal %}
+                        {% endif %}
                     </td>
=20
                     </tr>
diff --git a/bitbake/lib/toaster/toastergui/templates/target.html b/bitba=
ke/lib/toaster/toastergui/templates/target.html
index 1924a0dad7..d5f60e77a8 100644
--- a/bitbake/lib/toaster/toastergui/templates/target.html
+++ b/bitbake/lib/toaster/toastergui/templates/target.html
@@ -8,11 +8,11 @@
=20
 {% block nav-target %}
   {% for t in build.get_sorted_target_list %}
-    {% ifequal target.pk t.pk %}
+    {% if target.pk =3D=3D t.pk %}
       <li class=3D"active"><a href=3D"{% url 'target' build.pk t.pk %}">=
{{t.target}}</a><li>
     {% else %}
       <li><a href=3D"{% url 'target' build.pk t.pk %}">{{t.target}}</a><=
li>
-    {% endifequal %}
+    {% endif %}
   {% endfor %}
 {% endblock %}
=20
--=20
2.34.1


