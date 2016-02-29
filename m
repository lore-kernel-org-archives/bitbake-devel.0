Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 8A1D0731D6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 18:19:49 +0000 (UTC)
Received: by mail-pf0-f176.google.com with SMTP id t66so30410466pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=i7IVLD4TgDRWlgYuIR6zhqK5EyjlQq4ZP54Nkvvrqzw=;
	b=jWkduwPSKZ/YLHVBEy3d7vG1cgVjj3MMcPo8iH3nvffOtM4PJhNVvcdCOBtcdPU4+U
	OTjMtXuXQI/rBAxnPQSoJfPS67+RZAoorrmqZJc9xzhbSjpYtYIy2nig4RBeP1vZgh7v
	iuLiRu3CwaGYARp13JvS6CkZxjsYDUPyGW6vZtBfIifUBHSm7AkiCWk5bJinbRnWBiLd
	opnT9FvnLS3DCR7uKVZQ9nxh6zzyzvepC+NR05HkotT/91GTjWq3k/GcXwmD0rMXXAkB
	GGBYjsGF0Wq2zgxJefTuGV3N1jb0z/okBUecNKJW/APVwmQ73t8J2XDhE4f4ejstYvi3
	9i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=i7IVLD4TgDRWlgYuIR6zhqK5EyjlQq4ZP54Nkvvrqzw=;
	b=FF5se6BX5wJhySKdxn5QKV+dqRlOnwvocup+8RutrufLhyHU2MQwUnwWVLtL8M9aPj
	usdJOrMAQJqZvM9mMpjj0sX7e2gOhqIeKmOTkpdjZfsIZXUxKT5wgKiRDGFydbp1mQ2h
	T4rgcnHqmGQOgUuOXkYTu0zJsjbhoJUfXQVHFgkYKW0bYRhT22FUnbhUEvL8UZ4uMxho
	wo48lsdbPk/92Jo4xJkP/LYIIPo8Sw+H98TaIkV3rHIfDtD6ntrbKLuifhKuCoYGQi/q
	4uBAkZFISpbv9PKSDCN6JtVSJkJevbEPIIeO+3XC9R7RcZYVBupLFi/k8TEl/JqdZVIX
	7eYw==
X-Gm-Message-State: AD7BkJKNd5GrjQTdkrBswv879/H7zJ4g7ROHQBN3acuvHpaaYi8eTttnrYC48Hqj4ASpdw==
X-Received: by 10.98.32.18 with SMTP id g18mr10708200pfg.116.1456769989780;
	Mon, 29 Feb 2016 10:19:49 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	cq4sm39741081pad.28.2016.02.29.10.19.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 29 Feb 2016 10:19:49 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Feb 2016 10:25:57 -0800
Message-Id: <cover.1456770232.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/1] bitbake: Remove Hob ui
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
X-List-Received-Date: Mon, 29 Feb 2016 18:19:51 -0000

hob: removal of hob ui and associated ui files

    We've been gearing up the Toaster web UI to replace the Hob (GTK+ based) UI
    for some time now; Hob has basically been on life support for the past few
    releases. As of late last month in master, Toaster has the capability to
    select the packages in an image, removing the last thing that Hob could do
    that Toaster couldn't.

    To recap, the reasons why Hob is being removed include:

    - The code is tightly woven into BitBake, making it fragile. This means it
    needs significant QA and maintenance on an ongoing basis.

    - Some of the implementation is not ideal; we'll be able to remove some cruft
    from BitBake and OE-Core at the same time.

    - It's GTK+ 2 based, not the current GTK+ 3.

    - Toaster is now a much more capable UI and is being actively maintained

    The discussion about removing hob can be found at:
    http://lists.openembedded.org/pipermail/openembedded-architecture/2016-February/000082.html

-bavery

The following changes since commit 4006a7f2762ccd5dcbc6cdff49482d4387a73261:

  sanity: Fix int verses string reference (2016-02-28 22:54:09 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/bitbake/removeHobV2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/bitbake/removeHobV2

bavery (1):
  hob: removal of hob ui and associated ui files

 lib/bb/ui/crumbs/builddetailspage.py           |  437 -------
 lib/bb/ui/crumbs/builder.py                    | 1534 ------------------------
 lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |  341 ------
 lib/bb/ui/crumbs/hig/parsingwarningsdialog.py  |  163 ---
 lib/bb/ui/crumbs/hig/proxydetailsdialog.py     |   90 --
 lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   51 -
 lib/bb/ui/crumbs/hig/saveimagedialog.py        |  159 ---
 lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  891 --------------
 lib/bb/ui/crumbs/hobeventhandler.py            |  645 ----------
 lib/bb/ui/crumbs/hoblistmodel.py               |  903 --------------
 lib/bb/ui/crumbs/hobpages.py                   |  128 --
 lib/bb/ui/crumbs/imageconfigurationpage.py     |  561 ---------
 lib/bb/ui/crumbs/imagedetailspage.py           |  705 -----------
 lib/bb/ui/crumbs/packageselectionpage.py       |  355 ------
 lib/bb/ui/crumbs/recipeselectionpage.py        |  335 ------
 lib/bb/ui/crumbs/sanitycheckpage.py            |   85 --
 lib/bb/ui/hob.py                               |  109 --
 17 files changed, 7492 deletions(-)
 delete mode 100755 bitbake/lib/bb/ui/crumbs/builddetailspage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/builder.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/proxydetailsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hobeventhandler.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/hoblistmodel.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/hobpages.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/imagedetailspage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
 delete mode 100755 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
 delete mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
 delete mode 100755 bitbake/lib/bb/ui/hob.py

--
1.9.1

