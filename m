Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
 by mx.groups.io with SMTP id smtpd.web12.2889.1591123072508230091
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2020 11:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gmuPSL+F;
 spf=pass (domain: konsulko.com, ip: 209.85.210.67, mailfrom: paul.barker@konsulko.com)
Received: by mail-ot1-f67.google.com with SMTP id g25so11689609otp.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2020 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=/ar08QB/6GmuxebLsBxAUFeyJ+7S8/6Ikfb1tjVcyUE=;
        b=gmuPSL+FES0lAYemrNV/ER59E8/A3ZT7cINdIhUwmhec4yXBc2vsv/vs/jibnr4tVi
         jbKTKIPqhdhFBmaJPpHILOOK7yDDq7GsEU9xcDX7ceuhlg9DOoQ7zkT7+wvGGkYLFFB0
         YmyLVZAYKQZDDOqkEvjiu8Yru4O9DnYSj6Mng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/ar08QB/6GmuxebLsBxAUFeyJ+7S8/6Ikfb1tjVcyUE=;
        b=mBrN4+wqHEroXZyk4/3/5WBDQ8+bld/ceZp+ZaApl/58sPwn/BmXTvfggfmWZ2F1iu
         /WaN2S7NFwqZpIVHwOFFhiv8R6KC2/YX2FCHss05+C8hCLP5xbjNMsk42CZun3DNbM5E
         XGsEPsR6RBZsU61Mhn2CG/myJJDamoNDhaZswFJFzIlFa/2kGUm60ztYFEl2n8AEqRMs
         AfV9nh556hEQGAIsDs8lQ5Z0qnATesGAi0f51hz6qYl834WHi7lIbPxx97t9xRHi+N00
         lPVNOZqwGmumabaNlvcSwxcPpgGBhEpiH0vggc41bYcl7hBW8rQR847oii4EDWBCvVka
         eMow==
X-Gm-Message-State: AOAM5303GabIMz+4PJTbSgGTrQ4zCwH0DdWLHyxw4oah8B+8L44nKpFA
	ojfzJNLFdjM2IphIJcrj5OnSenrgfJfd9xrz2TqXP7T3D4k=
X-Google-Smtp-Source: ABdhPJxZwlgvTSEt15V3sgwZhVlzY+cazaG9faiWNR8vwChDBpCwqpnlAU2SvW0M4WQhBtWTxrTqrRtzdQxCsFxfXdY=
X-Received: by 2002:a9d:2f05:: with SMTP id h5mr481985otb.258.1591123071588;
 Tue, 02 Jun 2020 11:37:51 -0700 (PDT)
MIME-Version: 1.0
From: "Paul Barker" <pbarker@konsulko.com>
Date: Tue, 2 Jun 2020 19:37:36 +0100
Message-ID: <CAM9ZRVuraU8rtGy2oDxrF1shUORXLSHU=F0T5H9jkEf3_RZ7Hg@mail.gmail.com>
Subject: Task names in bitbake-diffsigs output
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

Running bitbake-diffsigs today to debug why sstate was not being
reused gave the following output:

NOTE: Starting bitbake server...
runtaskdeps changed:
[-autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-devtools/autoconf/autoconf_2.69.bb
automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-devtools/automake/automake_1.16.1.bb
bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
file/file_5.38.bb:do_fetch:virtual:native:/w/layers/poky/meta/recipes-devtools/file/file_5.38.bb
gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-devtools/gnu-config/gnu-config_git.bb,
+autoconf/autoconf_2.69.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-devtools/autoconf/autoconf_2.69.bb
automake/automake_1.16.1.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-devtools/automake/automake_1.16.1.bb
file/file_5.38.bb:do_fetch:virtual:native:/builds/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-devtools/file/file_5.38.bb
gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-devtools/gnu-config/gnu-config_git.bb,
'libtool/libtool-native_2.4.6.bb:do_populate_sysroot',
-zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-core/zlib/zlib_1.2.11.bb,
+zlib/zlib_1.2.11.bb:do_populate_sysroot:virtual:native:/builds/SanCloudLtd/meta-sancloud/layers/poky/meta/recipes-core/zlib/zlib_1.2.11.bb]
Number of task dependencies changed
Dependency on task
bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-extended/bzip2/bzip2_1.0.8.bb
was removed with hash
94572189ef6d0c9fd878611865331a20e71d33e294c9949de7146a1923c4175f

What's confusing there is that the bulk of the output is noise due to
the paths to various recipes being changed.

It got me thinking, where are those long task names like
"bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:/w/layers/poky/meta/recipes-extended/bzip2/bzip2_1.0.8.bb"
being generated? Why do they include the full path to the recipe?

Instead of including the full paths could we prefix the recipe path
with the collection name ()ince those are unique but won't change if
you move the layers around)? So instead you'd have something like
"bzip2/bzip2_1.0.8.bb:do_populate_sysroot:virtual:native:core:recipes-extended/bzip2/bzip2_1.0.8.bb".
If that's not too insane, and someone can point me at the code which
generates those task names I'd be happy to try patching it myself.

Thanks,

-- 
Paul Barker
Konsulko Group
