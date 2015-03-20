Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id D1FBD728C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:40 +0000 (UTC)
Received: by pdnc3 with SMTP id c3so105086274pdn.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wXu9HfMQIWl4dT4DHE81BKXJyXKwx3sFt1MyVDA7rvo=;
	b=k7OXh+90GOm9AAqSAsPyfOq4D+zQ5Ct/mCh+H9jwip9mG8x6VbDZPbcKFyjrojcqKz
	ykcNd1/zuRkkR5j0mNqteYSpTM8KzktCxCk/52zjy3M9PQILypf6FFPjL3diunfP8Qm+
	ne0SBOzjNt4MlWFWnl7/N74CgjcCKBQiu8Y7Jp9t8clVI7gv3+7OwRi/zZ3ijy3+qKgl
	ghzyQfH/4kWkBeFQf0qQh4WjUjq8NlVog+Ex4HeGEthk5FZHDiGxKAtwfhva5GFHyKA4
	ysQ/40C4BrOzUw6stpdFTU9jzXadxRjPcqn5O2CjouM4n2S4t/xxfAt1E/ZDach/sUug
	QyPw==
X-Gm-Message-State: ALoCoQmXzTYnWSEDVwWov/nQ1QjJKi5UKC6A6sFl2me72suR5s86kha5D5Dr+hbuDoxqgfWD4oAz
X-Received: by 10.70.48.239 with SMTP id p15mr126286484pdn.123.1426847142084; 
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id x3sm7465954pdo.0.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B6B3856444D; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:26 +0000
Message-Id: <5cde1c2e86c0df97f367e543a5856e3a2ee34ff6.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 09/14] toaster: leave cancel enabled for release change
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:41 -0000

From: Dave Lerner <dave.lerner@windriver.com>

When you click the 'change' icon to edit the project release, the
"cancel" button, should always be enabled so that the user can
return to the 'not editable' state at any time.

[YOCTO #7151]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/templates/project.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index badc8a6..35147c0 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -412,7 +412,7 @@ vim: expandtab tabstop=2
           <option ng-repeat="r in releases" value="{[r.id]}" ng-selected="r.id == project.release.id">{[r.description]}</option>
         </select>
         <input type="submit" class="btn" style="margin-left:5px;" value="Save" ng-disabled="project.release.id == projectVersion"/>
-        <input type="reset"  class="btn btn-link" value="Cancel" ng-click="toggle('#change-project-version')" ng-disabled="project.release.id == projectVersion"/>
+        <input type="reset"  class="btn btn-link" value="Cancel" ng-click="toggle('#change-project-version')"/>
 
       </form>
     </div>
-- 
1.9.1


