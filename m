Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id DC02B72D2C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:37 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id n3so5191121wiv.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dIVO5CSbJW0iB13jSyl0IlQpHxVPgwSNXeXtRw6Er94=;
	b=ASseeQdR4w+HulvnbMBkJ4PKUf6xfziJNKqAvMk9Y992QyJkKK68OtNH9TBYtgl6lI
	QDzDrZ3fsWKtWDRx9dXH0+Wg55WH/iWvmEnl2ytWwFpRU8fq5AlyWVGiTQ69WieZOlB2
	EIj7R9+QIGQJq17JkZ1yLS8EJCSZoNEytJIW2WoBVC/8G3S8nKmR/EeTsQjYneJ2ccuj
	dPCn2SC3xUUL2qbF/MyKGuXMCuc2hGsSILs73FVlt/8nBcz0G5T6evrw7bwshdoqVFQw
	umTVk0fKZvwAIwO5UIhRM3HibfOTviVm5QCqOpzBldeWrjJoOM6IjwaxaEBozZjpcIb1
	oJJg==
X-Gm-Message-State: ALoCoQnxpiv/rPoyELSnI/hOR/vwI7NPtvFTJGKs9/p0m5qSPbVejxxd/kFSoUCLYv59Mwnp2tDW
X-Received: by 10.180.91.109 with SMTP id cd13mr6470933wib.46.1422368857560;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l6sm2025131wjx.33.2015.01.27.06.27.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B21FF56265F; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:32 +0000
Message-Id: <947ef663e452c15933218fd680875ade7cb46e9a.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 11/14] toastergui: remove recipe id links to the layer index
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Toaster cannot use the recipe id to link to the layer
index, because recipe ids can change. We need to search
by the recipe name instead.

This patch removes the recipe id link from the layer
details page and replaces it with a search by the
recipe name.

It also makes sure links to the layer index open in
a new tab/window.

[YOCTO #7194]
[YOCTO #7193]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 2b57561..84a21d7 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -265,7 +265,7 @@
                         <td>
                           {{target.name}}
                           {% if target.up_id %}
-                          <a href="http://layers.openembedded.org/layerindex/recipe/{{target.up_id}}/" class="icon-share get-info"></a>
+                          <a href="{{target.get_layersource_view_url}}" class="icon-share get-info" target="_blank"></a>
                           {% endif %}
                         </td>
                         <td>{{target.version}}</td>
-- 
1.9.1


