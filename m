Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 59DEC6F92D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:20 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id hi2so2239631wib.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=srDNVx+HRJ6DRvQOE6t8g/s3IB/6HnqgG0RCSrTemKg=;
	b=O3faOqryrbOXyfjuPWXMCUwWHDBfM3A2WMJzCUUAruqrBazq0qtYbNcN3zKj4w9bTF
	B+g6GiOYQdSslb3oZS0ZtCl5qZOO3sxxTyyF77BwOunoMhVCppB7m0j36Fu+DkQAaILp
	rr0nQArL7L7tkVGtCMCozMeRYSUcRXYSwA/258M1bFjOZtWgKE68Zufg1hz8cBpaXJgq
	a3UdxevZnTI99qFJwZ4hf7IKR6v0y2RRuJdqymuaIEtKZZDQB/7yGg/BmiIo+f28pIjT
	gCV6tEE43bTG0o0nTEaens+of5HfIJ3HykHjhDZUk4pCZEqgs1XNTQbatfRikbHwF3DM
	0xdA==
X-Gm-Message-State: ALoCoQnG4Vr24nbJ+FdZxGEaygV4IrPk9IhYDKAzUxPg0EfCpASIizIjRegjVgAhjM2GcsmuHRTA
X-Received: by 10.180.231.39 with SMTP id td7mr6647503wic.14.1396284440410;
	Mon, 31 Mar 2014 09:47:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id hp5sm13861463wjb.0.2014.03.31.09.47.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1E1CE560425; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:13 +0100
Message-Id: <39785f6ce2df5c110b75cf8c5db8006e9733266c.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 13/14] toaster: unbuilt package dependency formats
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:21 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO 6057]

For a package shown on the package build dependency page, the dependent
packages may be unbuilt packages, as indicated with the dependent
package's size set to -1.  This fix changes the build template to use
the same formatting functions for unbuilt dependent packages as the
include package templates use for unbuilt dependent packages.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 .../templates/package_built_dependencies.html      | 75 ++++++++++------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index a2011d6..8613f1e 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -36,24 +36,21 @@
                     </thead>
                     <tbody>
 						{% for runtime_dep in runtime_deps %}
-                            {% ifequal runtime_dep.version '' %}
-                                <tr class="muted">
-                                    <td>{{runtime_dep.name}}</td>
-                                    <td>{{runtime_dep.version}}</td>
-                                    <td></td>
-                                    </div>
-                                </tr>
+                        <tr {{runtime_dep.size|format_vpackage_rowclass}} >
+                            {% if runtime_dep.size != -1 %}
+                            <td>
+                                <a href="{% url 'package_built_detail' build.id runtime_dep.depends_on_id %}">
+                                    {{runtime_dep.name}}
+                                </a>
+                            </td>
                             {% else %}
-                                <tr>
-                                    <td>
-                                        <a href="{% url 'package_built_detail' build.id runtime_dep.depends_on_id %}">
-                                            {{runtime_dep.name}}
-                                        </a>
-                                    </td>
-                                    <td>{{runtime_dep.version}}</td>
-                                    <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
-                                </tr>
-                            {% endifequal %}
+                            <td>
+                                {{runtime_dep.name|format_vpackage_namehelp}}
+                            </td>
+                            {% endif %}
+                            <td>{{runtime_dep.version}}</td>
+                            <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
+                        </tr>
 						{% endfor %}
                     </tbody>
                 </table>
@@ -74,31 +71,25 @@
                     </thead>
                     <tbody>
 						{% for other_dep in other_deps %}
-                        	{% ifequal other_dep.version '' %}
-                            	<tr class="muted">
-                                	<td>{{other_dep.name}}</td>
-                                	<td>{{other_dep.version}}</td>
-                                	<td></td>
-                                	<td>
-                                    	{{other_dep.dep_type_display}}
-                                    	<i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
-                                	</td>
-                            	</tr>
-                        	{% else %}
-                            	<tr>
-                                	<td>
-                                    	<a href="{% url 'package_built_detail' build.id other_dep.depends_on_id %}">
-                                        	{{other_dep.name}}
-                                    	</a>
-                                	</td>
-                                	<td>{{other_dep.version}}</td>
-                                	<td>{{other_dep.size|filtered_filesizeformat}}</td>
-                                	<td>
-                                    	{{other_dep.dep_type_display}}
-                                    	<i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
-                                	</td>
-                            	</tr>
-                        	{% endifequal %}
+                        <tr {{other_dep.size|format_vpackage_rowclass}} >
+                        {% if other_dep.size != -1 %}
+                            <td>
+                                <a href="{% url 'package_built_detail' build.id other_dep.depends_on_id %}">
+                                    {{other_dep.name}}
+                                </a>
+                            </td>
+                        {% else %}
+                            <td>
+                                {{other_dep.name|format_vpackage_namehelp}}
+                            </td>
+                        {% endif %}
+                            <td>{{other_dep.version}}</td>
+                            <td>{{other_dep.size|filtered_filesizeformat}}</td>
+                            <td>
+                                {{other_dep.dep_type_display}}
+                                <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
+                            </td>
+                        </tr>
                     	{% endfor %}
                     </tbody>
                 </table>
-- 
1.9.1


