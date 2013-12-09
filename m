Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 586E16E250
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449360039"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:42 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:17 +0000
Message-Id: <b102af0b7ebd2f06d6352b834ea083e959c21b0f.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 11/11] toaster: Add more information for tasks in Simple UI
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds more information about Tasks in the Simple UI:
* all local file system information is not listed in a single
column, showing the common relationship
* adding the display for the location of the task source
* we display the work directory for each task

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/templates/task.html | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldviewer/templates/task.html b/lib/toaster/bldviewer/templates/task.html
index 6a9979e..de965ab 100644
--- a/lib/toaster/bldviewer/templates/task.html
+++ b/lib/toaster/bldviewer/templates/task.html
@@ -14,12 +14,11 @@
             <th>Checksum</th>
             <th>Outcome</th>
             <th>Message</th>
-            <th>Logfile</th>
             <th>Time</th>
             <th>CPU usage</th>
             <th>Disk I/O</th>
             <th>Script type</th>
-            <th>File path</th>
+            <th>Filesystem</th>
             <th>Depends</th>
             </tr>
 
@@ -40,12 +39,17 @@
                 <td>{{task.sstate_checksum}}</td>
                 <td>{{task.get_outcome_display}}{% if task.provider %}</br>(by <a href="#{{task.provider.recipe.name}}.{{task.provider.task_name}}">{{task.provider.recipe.name}}.{{task.provider.task_name}}</a>){% endif %}</td>
                 <td><p>{{task.message}}</td>
-                <td><a target="_fileview" href="file:///{{task.logfile}}">{{task.logfile}}</a></td>
                 <td>{{task.elapsed_time}}</td>
                 <td>{{task.cpu_usage}}</td>
                 <td>{{task.disk_io}}</td>
                 <td>{{task.get_script_type_display}}</td>
-                <td><a target="_fileview" href="file:///{{task.recipe.file_path}}">{{task.recipe.file_path}}</a></td>
+                <td> <table>
+<tr><td>                Recipe</td><td><a target="_fileview" href="file:///{{task.recipe.file_path}}">{{task.recipe.file_path}}</a></td></tr>
+<tr><td>                Source</td><td><a target="_fileview" href="file:///{{task.file_name}}">{{task.file_name}}:{{task.line_number}}</a></td></tr>
+<tr><td>                Workdir</td><td><a target="_fileview" href="file:///{{task.work_directory}}">{{task.work_directory}}</a></td></tr>
+<tr><td>                Log</td><td><a target="_fileview" href="file:///{{task.logfile}}">{{task.logfile}}</a><br/></td></tr>
+</table>
+                </td>
                 <td>
             <div style="height: 3em; overflow:auto">
                 {% for tt in task.task_dependencies_task.all %}
-- 
1.8.1.2


