Return-Path: <davis.roman84@gmail.com>
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
	[209.85.167.48])
	by mail.openembedded.org (Postfix) with ESMTP id 3965278F35;
	Fri, 17 Aug 2018 19:11:01 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id u14-v6so6640597lfu.0;
	Fri, 17 Aug 2018 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=0FjwZMwDFr1C4NY+pD/FYkMzHx3lvkhE8FEIo+WgtHU=;
	b=ENK3+akr9YQe2XhfnqsUqtCUzf1L33TufY6aiHokasRuvcKaH7gImye5fzJ2Yv37Ok
	aM6w8Fzb3aTAiS7EMxnd2aI4ayFLCFwlKZjnDD16i1Aq/ZO4V850pLirqHXF7qG5atm5
	jil7FVAGIZVzGBDmNRxd4vsgLGOnggvkxgo/7mu9k8yIBiAoCKkBUGf/NixqxvuVHU6m
	95pfPxdQvQt3pPl7XNKmc9F0mzHxdGlhKzAaDm7nVTgekI32kZ/MHNvUX89rr4lpt/0i
	Kf68kTBREAjs27yhIv5R302RmjKp/4ENHx5BdvUINrChgNfHtiWIjmdKmCR3++pTa+XN
	pgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=0FjwZMwDFr1C4NY+pD/FYkMzHx3lvkhE8FEIo+WgtHU=;
	b=OMMgUeMypKpaqI3Yb9qMDaem/0fwfqPZ7Ods4gpqPLkIfymHzsoQB37E2MKD++0pQl
	UEl1T8v6owlsevsLh2uqWAkklgLMuk3tVh2nPIckzQP8JTpObunHMdgyYO4GwBRGgRbU
	BOggHBFDQi/Itk3MY8njKuigY/KJOxHdCnnTGQVLN+9L0/o8sAUYJxlmGwQzNYp1cvyE
	EIXiXNJIDW+QcdCjMNNX7BFFntEq+XrL81eJGahD22XxtV27DGmVxIwwnRiyJqep0P8m
	Cmb3/9you4JZ6WV7np8lMu+m2bCJUrvFVXPByePMaGsQ0PNBhs1xFYjEpCpY0SERNgGv
	z/EQ==
X-Gm-Message-State: AOUpUlF60vOutMFkIsOuacq152Rw+I5t4Aw7Ukkeyd5JHEy1eWAoZkRh
	fB8f0e+h+N/IQTdQ4PD8zySDN3gESf9FN9qy9cHJyK/I
X-Google-Smtp-Source: AA+uWPzRRL+W7e8buwJWE+nkfA4Dmc7TbjBwCihuyQGXRoIYSD1eAvegZZbU/O0mPZVpT4YlnJC4LpItdDlGCmEYE5I=
X-Received: by 2002:a19:c715:: with SMTP id
	x21-v6mr7685458lff.110.1534533061524; 
	Fri, 17 Aug 2018 12:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:1712:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 12:11:00
	-0700 (PDT)
From: Davis Roman <davis.roman84@gmail.com>
Date: Fri, 17 Aug 2018 15:11:00 -0400
Message-ID: <CACfi_Z2Zvwiq-iB7ckmmT0LgthOPRxCMC6OCSW3ywbZ2=oSY4A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	Yocto discussion list <yocto@yoctoproject.org>,
	openembedded-core@lists.openembedded.org
Subject: how to store a modification of a bbclass in the poky layer in my own layer.
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
X-List-Received-Date: Fri, 17 Aug 2018 19:11:01 -0000
Content-Type: text/plain; charset="UTF-8"

Hello!


I've made a modification in poky/meta/classes/libc-package.bbclass (
shown below)

However I don't want this change to be stored here long term and
instead feel that it should live in my project specific layer,
meta-hon-grip.

After checking with bitbake-layers, I saw that my layer has a higher
priority than the poky layer so my layer should be checked first ( or
so I thought)

I copied the modified version of libc-packages.bbclass into
meta-hon-grip/classes and I restored the version in the poky layer to
its original state.

After making this change, I found that the modified version in my
layer is not being used and instead the version in the poky layer is
the one in play.

I'm trying to figure out what else to try.

Any suggestions would be greatly appreciated!

Thank you,

Davis

diff --git a/meta/classes/libc-package.bbclass
b/meta/classes/libc-package.bbclass
index 467d567..72d447a 100644
--- a/meta/classes/libc-package.bbclass
+++ b/meta/classes/libc-package.bbclass
@@ -287,7 +287,7 @@ python package_do_split_gconvs () {
                 bb.error("locale_arch_options not found for
target_arch=" + target_arch)
                 raise bb.build.FuncFailed("unknown arch:" +
target_arch + " for locale_arch_options")

-            localedef_opts += " --force --old-style --no-archive --prefix=%s \
+            localedef_opts += " --force --no-archive --prefix=%s \
                 --inputfile=%s/%s/i18n/locales/%s --charmap=%s %s/%s" \
                 % (treedir, treedir, datadir, locale, encoding,
outputpath, name)

@@ -295,7 +295,7 @@ python package_do_split_gconvs () {
                 (path, i18npath, gconvpath, localedef_opts)
         else: # earlier slower qemu way
             qemu = qemu_target_binary(d)
-            localedef_opts = "--force --old-style --no-archive --prefix=%s \
+            localedef_opts = "--force --no-archive --prefix=%s \
                 --inputfile=%s/i18n/locales/%s --charmap=%s %s" \
                 % (treedir, datadir, locale, encoding, name)

