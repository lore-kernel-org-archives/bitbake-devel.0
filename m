Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
 by mx.groups.io with SMTP id smtpd.web10.15338.1593523634362811472
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2020 06:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hWjX4q7W;
 spf=pass (domain: konsulko.com, ip: 209.85.210.66, mailfrom: paul.barker@konsulko.com)
Received: by mail-ot1-f66.google.com with SMTP id c25so773992otf.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2020 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MH7cD6xZrFP4PXpe+CfdQMFu6iVHSgE53DmsoXXBmmw=;
        b=hWjX4q7WglTWot7IbWeHtSjJeum4wyeI6kLeuq1skukQDoMuRg9est8WSG2Q4cPRw+
         dYwjntjqkS7FL2+GLut7w7R+NtwNwRczJnxaJIS7f/U+/gqoFLPsPt9D2AAh/aWbidFv
         s6JjBgHVlVyXVf/LugnTkjmiMr3T3GHtlgyX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MH7cD6xZrFP4PXpe+CfdQMFu6iVHSgE53DmsoXXBmmw=;
        b=LnEUgG7iHVNiCGpS9NWG0j7iwyER5N1y3iHeGTRU0/kkaPzDrXdrZvRohCjqJQtdpl
         +KEepRvJue0J7s2t9yo/w3mmAAXbGrfIxV1hYi4o5YwJ+S7bJ4IDehsXRoJqGfTXlbA9
         UUZ4IUv/D0MFVu+8NblwKiEOKYeRXZiLlAV42n4tNZU3FQB/Au9pp2E/GZsLKHLdQjBO
         hg7WXYDOKk1v4f6KXppRwoKUq0FiS6s0m6PPecdJ0yrARFLv/IOr312lmM5AmL1djT6J
         TtDuwZYfDdbLDGhTvbIHqshZVpB95WDui2UY0kxJz/aGBHtC2MAHfb3VAEu6SDQRf0Jf
         yVDQ==
X-Gm-Message-State: AOAM532imQKFntfO2RCXMXIAP3BKe6N+oNdyrZ+FaPROEYaU/TnuPqUW
	x5u87XZR53rMr6w7Y/OQNQadxdMfXLU44QEkt+N6h6pCgz8=
X-Google-Smtp-Source: ABdhPJywcJZBC0+0eDb8C/IlzqkiPKY4d/i9Hy7OF4p8b59OJ7OzbBF5TEmg853/s6q0EUjdYSRJgUtHvL0cMjdrzxw=
X-Received: by 2002:a05:6830:1e3a:: with SMTP id t26mr13459226otr.258.1593523632805;
 Tue, 30 Jun 2020 06:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593486375.git.steve@sakoman.com> <7ee38d7f6eae1c938842ddcc3aae49e462569df3.1593486375.git.steve@sakoman.com>
In-Reply-To: <7ee38d7f6eae1c938842ddcc3aae49e462569df3.1593486375.git.steve@sakoman.com>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Tue, 30 Jun 2020 14:27:04 +0100
Message-ID: <CAM9ZRVsxxWeC5wGH0dZTTR0GPNbgP+--0nMFQ+j0_Uh-5nxCMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 1/6] taskdata: Improve handling of regex in ASSUME_PROVIDED
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2020 at 04:08, Steve Sakoman <steve@sakoman.com> wrote:
>
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> ASSUME_PROVIDED can take regexs however the current way of handling
> this in code is suboptimal. It means that you can add something like:
>
> DEPENDS += "texinfo-nativejunk-that-does-not-exist"
>
> and if texinfo-native is in ASSUME_PROVIDED, no error will occur.
>
> Update the code to only treat something as a regex if a start or end
> anchor character is present (which wouldn't be valid in a recipe name).
>
> [YOCTO #13893]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit 3d72e23109990970fbb1086923277af752168b4a)
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/taskdata.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
> index d13a1249..ffbaf362 100644
> --- a/lib/bb/taskdata.py
> +++ b/lib/bb/taskdata.py
> @@ -21,8 +21,13 @@ def re_match_strings(target, strings):
>      Whether or not the string 'target' matches
>      any one string of the strings which can be regular expression string
>      """
> -    return any(name == target or re.match(name, target)
> -               for name in strings)
> +    for name in strings:
> +        if name.startswith("^") or name.endswith("$"):
> +            if re.match(name, target):
> +                return True
> +        elif name == target:
> +            return True
> +    return False
>
>  class TaskEntry:
>      def __init__(self):
> --
> 2.17.1

I'm not sure we should be changing how ASSUME_PROVIDED is parsed on a
stable branch. If we do backport this we should at least issue a
warning where the behaviour changes (i.e. if re.match(name, target) is
true but name != target and name doesn't start with ^ or end with $).

-- 
Paul Barker
Konsulko Group
