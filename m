Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id B859672D14
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:37 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id l15so5375102wiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GYSxNwa2ZgxpKqbz85yq/jJGbrblregNmL2oEo2WF60=;
	b=Dk8J4ZnmUjVMiy3wqAOjVVN89vCojf5R4qGy+AnjrJgDQwVBep2MraHlZUh2ozPjzF
	0H2SGxuCCpla07K5WlLyUVka87yWVDdmuna2c197GDf/bw6jn2OG2W4Kp6yno1PTkp/B
	3lxVTqS5WY57BVA407gO/n6ZYlwm6G+sDYWiTy+7IMp+gCwjBKIkrcepebzeSrs1c7yN
	HoJCulV3FnnH8Vx9QE+Vn7s4GjwxYBiNRFbye5mI6t0VcZZkGMIgUg0LdUFpSzMGK4rx
	DLpuv1ZT9QGZnaX8YDXnBRXrPWjYLvjYEm4iiFHHgz+Ehy+xfly7tIOyhNdv3X3y+5Uz
	aajg==
X-Gm-Message-State: ALoCoQkQZtm2YM8BvPGSRcn+JhgX3y8IKBXZmrLJuHPeD2s7tamqdddmRjz5RWrsmM9Jx8nQBKsX
X-Received: by 10.194.6.70 with SMTP id y6mr3079992wjy.97.1422368857900;
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id et4sm2042020wjd.15.2015.01.27.06.27.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B09635625F3; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:31 +0000
Message-Id: <4d52ceb7e66835a3088d83cd4caa002a3e7a1297.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 10/14] toastergui: consistent capitals in button
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

Capitalise correctly the 'Build target' button label in
the layer details page: it should match the table heading.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 1daf9b9..2b57561 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -270,7 +270,7 @@
                         </td>
                         <td>{{target.version}}</td>
                         <td>{{target.summary}}</td>
-                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build Target</button></td>
+                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build target</button></td>
                       </tr>
                       {% endfor %}
                     </tbody>
-- 
1.9.1


