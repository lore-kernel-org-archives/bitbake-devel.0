Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.120907.1597960242887816009
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 14:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=KZr+rA4a;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id p4so2935125qkf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2020 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiHEBESnWQozE6ZV1z5lqsxKN4IAPXa3IHlFxNcn7wI=;
        b=KZr+rA4aZ7PuViyaM6Es21bGu5DL3skiRfo2+VqfCYt5HvZkVYAlJBpdjV92KTa9ZL
         CbnnjcJvp0F09Yb4D6E80pq/L54jrZ80TypbIpC5oXUYZQ+TFPzrIOCznkrO3JaDJ6Gh
         VtV6uQXb24zIbsrBT2Eihc4RNTrY0egUOlVPtPQ553YS5nGBAuFhomepK6DmEP4HHUog
         gJz18YkbByVIIYCqiDAmLhNfv2LDg0LO/xnqCeCbP9UCxpJaKBr5Y+qgvqOfKxqiRMyU
         VEOwTx9/Dh6A7YXkPkcoC9ddkFnQtQiz7e0mcmoe8CXct+FVvNkaarvNyBk4A6ql9835
         SCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiHEBESnWQozE6ZV1z5lqsxKN4IAPXa3IHlFxNcn7wI=;
        b=E02sex7I5cNKlj5TAHBuGz4YiCQQgavv652T2sdSexXB/f3ITlV2ds+ZLlgBmAUcEY
         gKruXdFCDJicgfX0RSRD6quyn8GAZIV6XnxI53wgqre4cQOVwY1wOXrJpcCf0Yn0+n+W
         dycErcWDWQtuEPiYitvk+0uFCaix9VZ4JW0tZ0scrFbg54qzlWB5SXrGRJgy8dPcJjew
         jmp1LyelyGlGE60/Hoj4RdpQjD2Xs26ozuCxPO+io3WBoydV8ru/xtAJj9XSIEfgpFWt
         a/RGGaIWvYgRzInaJa1k1d2O48XZG9vKCpwEn/qsb4KZQLkcrSeK/Q3jn+poFPQPRWSG
         rC0g==
X-Gm-Message-State: AOAM530AH2ROGssWIwIbKXF8/kZeCBRZdDKqbApZnjVvkpxpUtd2AjTk
	yNbVvCcFD9ggyOQ9EDO6m7jTJJ7hYMqVGQ==
X-Google-Smtp-Source: ABdhPJzkEtqkSRiF6q8hb8oQUninR6NWIHUt1hgxoKBFYO+IC7M7OmqGU3nK0Tr98Gc3/rRRTb1UPQ==
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr39702qke.110.1597960241843;
        Thu, 20 Aug 2020 14:50:41 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id x28sm3407534qki.55.2020.08.20.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:50:41 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
	guillaume.champagne@sonatest.com,
	jeff.dagenais@gmail.com
Subject: [RFC] siggen: clean_basepath leaks full recipe file path
Date: Thu, 20 Aug 2020 17:49:59 -0400
Message-Id: <20200820215000.30818-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

While investigating constant mismatches of hashes from our SSTATE_MIRROR depot,
Maxime and I came across a bitbake-diffsigs which showed a suspicious cause for
the mismatch. It appeared to be an underlying taskdeptasks which contains the
full path of the recipe, which is totally a local build thing.

After searching for a little while. We came accross the `clean_basepath(a)`
function in siggen.py. We added prints on it:

def clean_basepath(a):
    mc = None print('a: ' + a) if a.startswith("mc:"):
        _, mc, a = a.split(":", 2)
    b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2] print('b: ' + b) if
    a.startswith("virtual:"):
        b = b + ":" + a.rsplit(":", 1)[0]
    if mc:
        b = b + ":mc:" + mc
    print('b+: ' + b) return b

Sure enough, this looks like the culprit. Consider the following trace:
a: virtual:native:/full/path/to/poky/meta/recipes-devtools/gnu-config/gnu-config_git.bb:do_populate_sysroot
b: gnu-config/gnu-config_git.bb:do_populate_sysroot
b+: gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native:/full/path/to/poky/meta/recipes-devtools/gnu-config/gnu-config_git.bb

Looking at this, it really seems like the intent of the `if
a.startswith("virtual:")` case is to insert only the `:virtual:native` at the
end.

The simplest fix we suggest is simply changing `a.rsplit(":", 1)[0]` to
`a.rsplit(":", 2)[0]` and causes b+ to become:

b+: gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native

Since this is so profound and core to the way signatures work, coupled with the
fact that this code hasn't changed in years, we feel being the ones to find and
fix this is unlikely.

Perpahps the content/format of the passed `a` variable has changed recently?

The following email is a patch which could be applied if deemed correct. But please
consider this re-written version:

def clean_basepath(basepath):
    # basepath is a string like '/full/path/to/recipes-whatever/helloworld/helloworld_0.1.2.bb:do_compile'
    # or 'virtual:native:/full/path/to/recipes-whatever/helloworld/helloworld_0.1.2.bb:do_compile'
    # or 'mc:somemachine:/full/path/to/recipes-whatever/helloworld/helloworld_0.1.2.bb:do_compile'

    _, parent_dir, recipe_task = basepath.rsplit("/", 2)
    # drop what is left of the second slash, searching from right to left
    cleaned = parent_dir + '/' + recipe_task

    # if there was a 'abc:xyz' prefix, add it to the end
    if not basepath.startswith('/'):
        cleaned += ':' + basepath.split('/', 1)[0].rstrip(':')

    return cleaned

Both simple fix and this rewrite were tested with `oe-selftest -r sstatetests`.

We feel this version has these advantages:
* improved readablility
* improved efficiency (the split is not repeated twice and function it has fewer `if`s)
* honours the open/close principle better by not hardcoding "virtual:" nor "mc:"

Thanks for your feedback! I will submit this version as a patch if it is positive.


