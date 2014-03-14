Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 885A36F855
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:03 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id l18so2478038wgh.19
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CDtWw3/QW8jvhKenDweKEHLg5qyf1i8sIJNFbbDq/5I=;
	b=deMuvCAGxIOisQrk8SFN4OoFsazjlRB5mYz3yajZPpz98TK60YgFwOC1LwOT5RaRbI
	THQwo+cCy+r5eqjvsbPPQ7a2nG93erSzim03iDlMm3s0FH0Qq3Rvsq+BfoBMaGdczzy2
	gb/q7+XNJ9LpmLJgo/t55icqmKITd3Xu937un5Pf5QnH/2Z/ta1zCKxgIKknAc1iI845
	y5oR5eqzfX7bgow60DLM4Ih5et8r5tbMFdayphxIBcBHl19JJOuKxXoi4i2sSXbWjGyL
	zEHX0Nx9rEXgRta9c69a1HjO7TX4d4KwZJm/nCfEpDdPgKfK1Wi7WD7rEvj9kHH9y3Y7
	1O6w==
X-Gm-Message-State: ALoCoQm64AsUHMoQ514kEKBNobp8HN5H/qO0SdbXSYkVCQCSQfsqidyRGqrXN+mcOnIBbBSSF9Cg
X-Received: by 10.180.164.174 with SMTP id yr14mr7319209wib.18.1394819944782; 
	Fri, 14 Mar 2014 10:59:04 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id mw3sm36757929wic.7.2014.03.14.10.59.01
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:03 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0BB32561066; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:44 +0000
Message-Id: <0c111b24e9f86130bc43c1327a6d12026e92cdf2.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 03/19] toaster: Move <tbody> outside for statement
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:05 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the package details pages, the <tbody> tags where inside
the for statements, which caused multiple <tbody> tags to
be generated inside a single table.

To make sure only one <tbody> tag exists per table, moving
the <tbody> tag outside the for statement.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 .../templates/package_built_dependencies.html      | 70 +++++++++++-----------
 .../toastergui/templates/package_built_detail.html | 10 ++--
 .../templates/package_included_dependencies.html   | 19 +++---
 .../templates/package_included_detail.html         |  8 +--
 .../package_included_reverse_dependencies.html     |  8 +--
 5 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index c67f60e..4932f74 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -35,8 +35,8 @@
                             <th>Size</th>
                         </tr>
                     </thead>
-                    {% for runtime_dep in runtime_deps %}
-                        <tbody>
+                    <tbody>
+						{% for runtime_dep in runtime_deps %}
                             {% ifequal runtime_dep.version '' %}
                                 <tr class="muted">
                                     <td>{{runtime_dep.name}}</td>
@@ -55,8 +55,8 @@
                                     <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
                                 </tr>
                             {% endifequal %}
-                        </tbody>
-                    {% endfor %}
+						{% endfor %}
+                    </tbody>    
                 </table>
             {% endifequal %}
             {% ifnotequal other_deps|length 0 %}
@@ -67,43 +67,41 @@
                             <th>Package</th>
                             <th>Version</th>
                             <th>Size</th>
-
                             <th>
                                 <i class="icon-question-sign get-help" title="There are 5 relationship types: recommends, suggests, provides, replaces and conflicts"></i>
                                 Relationship type
                             </th>
                         </tr>
-                    </thead>
-
-                    {% for other_dep in other_deps %}
-                        <tbody>
-                        {% ifequal other_dep.version '' %}
-                            <tr class="muted">
-                                <td>{{other_dep.name}}</td>
-                                <td>{{other_dep.version}}</td>
-                                <td></td>
-                                <td>
-                                    {{other_dep.dep_type_display}}
-                                    <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
-                                </td>
-                            </tr>
-                        {% else %}
-                            <tr>
-                                <td>
-                                    <a href="{% url 'package_built_detail' build.id other_dep.depends_on_id %}">
-                                        {{other_dep.name}}
-                                    </a>
-                                </td>
-                                <td>{{other_dep.version}}</td>
-                                <td>{{other_dep.size|filtered_filesizeformat}}</td>
-                                <td>
-                                    {{other_dep.dep_type_display}}
-                                    <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
-                                </td>
-                            </tr>
-                        </tbody>
-                        {% endifequal %}
-                    {% endfor %}
+                    </thead>       
+                    <tbody>
+						{% for other_dep in other_deps %}
+                        	{% ifequal other_dep.version '' %}
+                            	<tr class="muted">
+                                	<td>{{other_dep.name}}</td>
+                                	<td>{{other_dep.version}}</td>
+                                	<td></td>
+                                	<td>
+                                    	{{other_dep.dep_type_display}}
+                                    	<i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
+                                	</td>
+                            	</tr>
+                        	{% else %}
+                            	<tr>
+                                	<td>
+                                    	<a href="{% url 'package_built_detail' build.id other_dep.depends_on_id %}">
+                                        	{{other_dep.name}}
+                                    	</a>
+                                	</td>
+                                	<td>{{other_dep.version}}</td>
+                                	<td>{{other_dep.size|filtered_filesizeformat}}</td>
+                                	<td>
+                                    	{{other_dep.dep_type_display}}
+                                    	<i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
+                                	</td>
+                            	</tr>
+                        	{% endifequal %}
+                    	{% endfor %}
+                    </tbody>
                 </table>
                 {% endifnotequal %}
             </div> <!-- tab-pane -->
diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index fe856a3..b50ef53 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -29,15 +29,15 @@
                             <th>File</th>
                             <th>Size</th>
                         </tr>
-                    </thead>
-                    {% for file in package.buildfilelist_package.all|dictsort:"path" %}
-                        <tbody>
+                    </thead>                   
+                    <tbody>
+						{% for file in package.buildfilelist_package.all|dictsort:"path" %}
                             <tr>
                                 <td>{{file.path}}</td>
                                 <td>{{file.size|filtered_filesizeformat}}</td>
                             </tr>
-                        </tbody>
-                    {% endfor %}
+						{% endfor %}
+                    </tbody>
                 </table>
 
             {% else %}
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index c8c2ddd..00d42e7 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -21,8 +21,8 @@
                         <th>Size</th>
                     </tr>
                 </thead>
-                {% for runtime_dep in runtime_deps %}
-                    <tbody>
+                <tbody>
+					{% for runtime_dep in runtime_deps %}
                         <tr>
                             <td>
                                <a href="{% url 'package_included_detail' build.id target.id runtime_dep.depends_on_id %}">
@@ -32,8 +32,8 @@
                             <td>{{runtime_dep.version}}</td>
                             <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
                         </tr>
-                    </tbody>
-                {% endfor %}
+					{% endfor %}
+                 </tbody>                
             </table>
         {% else %}
             <div class="alert alert-info">
@@ -54,10 +54,9 @@
                             Relationship type
                         </th>
                     </tr>
-                </thead>
-
-                {% for other_dep in other_deps %}
-                    <tbody>
+                </thead>               
+                <tbody>
+					{% for other_dep in other_deps %}
                         {% if other_dep.installed %}
                             <tr>
                                 <td>
@@ -83,8 +82,8 @@
                                 </td>
                             </tr>
                         {% endif %}
-                    </tbody>
-                {% endfor %}
+					{% endfor %}
+                </tbody>               
             </table>
         {% endifnotequal %}
         </div> <!-- end tab-pane -->
diff --git a/lib/toaster/toastergui/templates/package_included_detail.html b/lib/toaster/toastergui/templates/package_included_detail.html
index 018de3e..af56b21 100644
--- a/lib/toaster/toastergui/templates/package_included_detail.html
+++ b/lib/toaster/toastergui/templates/package_included_detail.html
@@ -20,8 +20,8 @@
                         <th>Size</th>
                     </tr>
                 </thead>
-                {% for file in package.buildfilelist_package.all|dictsort:"path" %}
-                    <tbody>
+                <tbody>
+					{% for file in package.buildfilelist_package.all|dictsort:"path" %}
                         <tr>
                             <td>
                                 <a href="{% url 'image_information_dir' build.id target.id file.id %}">
@@ -30,8 +30,8 @@
                              </td>
                             <td>{{file.size|filtered_filesizeformat}}</td>
                         </tr>
-                    </tbody>
-                {% endfor %}
+					{% endfor %}
+                </tbody>
             </table>
 
             {% else %}
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 9cfc7fe..8ae0af3 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -26,8 +26,8 @@
                         <th>Size</th>
                     </tr>
                 </thead>
-                {% for reverse_dep in reverse_deps|dictsort:"name" %}
-                    <tbody>
+                <tbody>
+					{% for reverse_dep in reverse_deps|dictsort:"name" %}
                         <tr>
                             <td>
                                 <a href="{% url 'package_included_detail' build.id target.id reverse_dep.dependent_id %}">
@@ -37,8 +37,8 @@
                             <td>{{reverse_dep.version}}</td>
                             <td>{{reverse_dep.size|filtered_filesizeformat}}</td>
                         </tr>
-                    </tbody>
-                {% endfor %}
+					{% endfor %}
+                </tbody>
             </table>
         {% endifequal %}
         </div> <!-- end tab-pane -->
-- 
1.8.3.2


