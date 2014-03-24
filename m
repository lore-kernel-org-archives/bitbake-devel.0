Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 86F1A6FB08
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:31 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id x13so3748182wgg.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=StaACveANrDnfd0fZzqNKY+cn1f20jn+zNkUN6k+4O4=;
	b=Fi3q9S253gZ1uaDUXXlEh1OLXFkcAszgLviufaYN0dz9jwlWT10st+w1Juwyjq+x3h
	DvFmCiJPPjOQr8G054qD6CL6pM0XgJzDJVbsO3B0xZgD4ZO6pasUgopAAuse5XFHZ/2x
	nM9hzUVxzIJPEaWYIjxkO2/aBJ7IpgFIATRTJNCQmO7FMyV9jV/azV7vMBUepQIO0Z0u
	hW2vPuR0tPRyTggKzd4blKnhjEG10k4xFvcI9nf5xGKQAcTN294tENgnPkk0pQYMEMyn
	OLdCCRGYYRh12ub8lx0W51OT0zefj3C6nx2hlR5F3fS3ZOvRaLYff1Ylk58S12ir8nhO
	tvBA==
X-Gm-Message-State: ALoCoQlaNQM1/Wcrzg56y0cOZYN5QiDU2JB4jDGT0Ig+x1gn3S2KWo5qNgGdChty7mSMpcV2rAU8
X-Received: by 10.180.98.232 with SMTP id el8mr16527590wib.27.1395686252788;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm41449082wib.8.2014.03.24.11.37.31
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B0E26560FA6; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:12 +0000
Message-Id: <6be58123fcdb0ff20de2a88315e1e3012effd1d3.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 02/18] toaster: warn new filter replaces existing filter
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

If the user pop-ups a filter dialog when another filter is already
active, warn the user that the new filter would replace the
previous filter.

[YOCTO #5960]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css       | 1 +
 lib/toaster/toastergui/templates/filtersnippet.html | 5 +++++
 lib/toaster/toastergui/templatetags/projecttags.py  | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 53a3fee..d960f4b 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -105,6 +105,7 @@ select { width: auto; }
 .no-results { margin: 10px 0; }
 .task-name { margin-left: 7px; }
 .icon-hand-right {color: #ccccc; }
+.help-inline { margin: 5px; }
 
 
 
diff --git a/lib/toaster/toastergui/templates/filtersnippet.html b/lib/toaster/toastergui/templates/filtersnippet.html
index e0e1181..a72eeaa 100644
--- a/lib/toaster/toastergui/templates/filtersnippet.html
+++ b/lib/toaster/toastergui/templates/filtersnippet.html
@@ -28,6 +28,11 @@
         </div>
         <div class="modal-footer">
             <button type="submit" class="btn btn-primary">Apply</button>
+            {% if request.GET.filter %}
+                {% if request.GET.filter|string_remove_regex:':.*' != f.options.0.1|string_remove_regex:':.*' %}
+                <span class="help-inline pull-left">You can only apply one filter to the table. This filter will override the current filter.</span>
+                {% endif %}
+            {% endif %}
         </div>
 </form>
 
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index e7b23cb..39e92ce 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -189,6 +189,12 @@ def string_slice(strvar,slicevar):
         return strvar[int(first):int(last)]
 
 @register.filter
+def string_remove_regex(value,ex):
+    """ remove sub-string of string that matches regex
+    """
+    return re.sub(ex, '', value)
+
+@register.filter
 def filtered_installedsize(size, installed_size):
     """If package.installed_size not null and not empty return it,
        else return package.size
-- 
1.8.3.2


