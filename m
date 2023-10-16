Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9FCDB465
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 21:35:03 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.180961.1697492093586068423
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Oct 2023 14:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lOI7oaMU;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a86b6391e9so21603157b3.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697492093; x=1698096893; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzwsGR0SIhpqclpIoX8Jkbo6FqBzx8SM/ZX8N3jGB2U=;
        b=lOI7oaMUvxwlu7FuqtUXbMLWLS2NBK+bqD4I7rKD3KdqDTsWvdf2DnooD55PiRdMvG
         teARH4JBUFz7VuM4U2tPGz/E/ZiaBUmAuPHE/6BLHaU0LF5vYvj1R7Oae2rUmXwEEVGh
         Pxm/GaaNaMvDafOxvwggRULM8iNX0be070Ry64MUC0JNUcCix39e8Bky7+mHuEI3/GeU
         laSk+jK8HUbr30IR9eT2kcG3mk50SWQYdynU4rQ+McwqIHk2G/NZU+w3xvUkC93TztGC
         wF9qYdwYCRz2IhFRRlWQ/5t3frcEjneYuPfVS/Ob8rNpVlA7uH+z3n7T3SIcsH1NF+wA
         midQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492093; x=1698096893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzwsGR0SIhpqclpIoX8Jkbo6FqBzx8SM/ZX8N3jGB2U=;
        b=ga25LKCLghBOIPTXf3ZEuVQbZmg3cQjRpq//gJIJKTQoCkkaWM5Aj1YsNHA4Qn5b7s
         dawXXK98UN4OF8OdHIx7e95EymcwRoYBhE1rxCehRnU9nsZ1KxnOTmxLQhRr2Ij9phUb
         UxQM2s1ZEmvSW3CyizVBOuuR3MVx4UKdc/bTCPQFnQq+zUlNrsLF46gvAX1CX9bQMWre
         tX+Ti4kuMBEJzY8BiZLNVeBjDZ6FC/02lbw9UMx39Th6EL4zTQb78Cyk1VQ101PFrTFA
         wFsSYI4qGzSuydCMscqqqJA8RB/++LM3+LPjcbmoajdUHVCcn+aB8i/ypoQ1bRRewl+t
         vFAQ==
X-Gm-Message-State: AOJu0YyYXwa0GnP2OVgrpJccLAZR3BZMPGC6BM9OkkvqxgVIBqBzieLC
	DlEZc5O412pBKffdrGpAJAc21WThPdB4Pk4Mq8i9qsd40bM=
X-Google-Smtp-Source: AGHT+IE8QomKnUDHd4OpDOFZqtkVmdc72/T+sS0jmt4DOgweldzWbaeyvpc+L3MN1Fq4g9IUsmMEM0xIYlR4zvciF9M=
X-Received: by 2002:a05:690c:10c:b0:5a7:bc78:81e7 with SMTP id
 bd12-20020a05690c010c00b005a7bc7881e7mr378675ywb.30.1697492092089; Mon, 16
 Oct 2023 14:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231016160439.65034-1-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: <20231016160439.65034-1-marlon.rodriguez-garcia@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Mon, 16 Oct 2023 14:34:40 -0700
Message-ID: <CANx9H-AOWx8SC_k512-aCb5c1BiG+LcgJJmbzS=2hk2hqepUKg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 4/4] toaster: Update bootstrap version
 to 3.4.1
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002879640607dc2d7e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 21:35:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15248

--0000000000002879640607dc2d7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 9:04=E2=80=AFAM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> Update bootstrap version to 3.4.1 to fix incompatibility issues and
> security vulnerabilities
>

The link to the nvd vulnerabilities that I included in the review would be
helpful here but I'll let it go.


> Files base, base_specific and js-unit-test were updated to match new
> versions of files
>
> Changes in v2:
> Update bootstrap version from 3.3.7 to 3.4.1 and explicit name version in
> files
>
> "Changes in v2" belongs below the --- line (which is right after your
Signed-off-by: in the email patch) as it is part of the review and we do
not want it in the final git history.


> Signed-off-by: Marlon Rodriguez Garcia <
> marlon.rodriguez-garcia@savoirfairelinux.com>
>
Reviewed-by: Tim Orling <tim.orling@konsulko.com>


> ---
>  .../js/{bootstrap.js =3D> bootstrap-3.4.1.js}   | 431 +++++++++++++-----
>  .../static/js/bootstrap-3.4.1.min.js          | Bin 0 -> 39680 bytes
>  .../toastergui/static/js/bootstrap.min.js     | Bin 37049 -> 0 bytes
>  lib/toaster/toastergui/templates/base.html    |   2 +-
>  .../toastergui/templates/base_specific.html   |   4 +-
>  .../toastergui/templates/js-unit-tests.html   |   2 +-
>  6 files changed, 328 insertions(+), 111 deletions(-)
>  rename lib/toaster/toastergui/static/js/{bootstrap.js =3D>
> bootstrap-3.4.1.js} (84%)
>  create mode 100644 lib/toaster/toastergui/static/js/bootstrap-3.4.1.min.=
js
>  delete mode 100644 lib/toaster/toastergui/static/js/bootstrap.min.js
>
> diff --git a/lib/toaster/toastergui/static/js/bootstrap.js
> b/lib/toaster/toastergui/static/js/bootstrap-3.4.1.js
> similarity index 84%
> rename from lib/toaster/toastergui/static/js/bootstrap.js
> rename to lib/toaster/toastergui/static/js/bootstrap-3.4.1.js
> index d47d640f..170bd608 100644
> --- a/lib/toaster/toastergui/static/js/bootstrap.js
> +++ b/lib/toaster/toastergui/static/js/bootstrap-3.4.1.js
> @@ -1,6 +1,6 @@
>  /*!
> - * Bootstrap v3.3.6 (http://getbootstrap.com)
> - * Copyright 2011-2016 Twitter, Inc.
> + * Bootstrap v3.4.1 (https://getbootstrap.com/)
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under the MIT license
>   */
>
> @@ -11,16 +11,16 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  +function ($) {
>    'use strict';
>    var version =3D $.fn.jquery.split(' ')[0].split('.')
> -  if ((version[0] < 2 && version[1] < 9) || (version[0] =3D=3D 1 &&
> version[1] =3D=3D 9 && version[2] < 1) || (version[0] > 2)) {
> -    throw new Error('Bootstrap\'s JavaScript requires jQuery version
> 1.9.1 or higher, but lower than version 3')
> +  if ((version[0] < 2 && version[1] < 9) || (version[0] =3D=3D 1 &&
> version[1] =3D=3D 9 && version[2] < 1) || (version[0] > 3)) {
> +    throw new Error('Bootstrap\'s JavaScript requires jQuery version
> 1.9.1 or higher, but lower than version 4')
>    }
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: transition.js v3.3.6
> - * http://getbootstrap.com/javascript/#transitions
> + * Bootstrap: transition.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#transitions
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -28,7 +28,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  +function ($) {
>    'use strict';
>
> -  // CSS TRANSITION SUPPORT (Shoutout: http://www.modernizr.com/)
> +  // CSS TRANSITION SUPPORT (Shoutout: https://modernizr.com/)
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    function transitionEnd() {
> @@ -50,7 +50,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      return false // explicit for ie8 (  ._.)
>    }
>
> -  // http://blog.alexmaccaw.com/css-transitions
> +  // https://blog.alexmaccaw.com/css-transitions
>    $.fn.emulateTransitionEnd =3D function (duration) {
>      var called =3D false
>      var $el =3D this
> @@ -77,10 +77,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: alert.js v3.3.6
> - * http://getbootstrap.com/javascript/#alerts
> + * Bootstrap: alert.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#alerts
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -96,7 +96,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      $(el).on('click', dismiss, this.close)
>    }
>
> -  Alert.VERSION =3D '3.3.6'
> +  Alert.VERSION =3D '3.4.1'
>
>    Alert.TRANSITION_DURATION =3D 150
>
> @@ -109,7 +109,8 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        selector =3D selector && selector.replace(/.*(?=3D#[^\s]*$)/, '') =
//
> strip for ie7
>      }
>
> -    var $parent =3D $(selector)
> +    selector    =3D selector =3D=3D=3D '#' ? [] : selector
> +    var $parent =3D $(document).find(selector)
>
>      if (e) e.preventDefault()
>
> @@ -172,10 +173,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: button.js v3.3.6
> - * http://getbootstrap.com/javascript/#buttons
> + * Bootstrap: button.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#buttons
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -192,7 +193,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      this.isLoading =3D false
>    }
>
> -  Button.VERSION  =3D '3.3.6'
> +  Button.VERSION  =3D '3.4.1'
>
>    Button.DEFAULTS =3D {
>      loadingText: 'loading...'
> @@ -214,10 +215,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>        if (state =3D=3D 'loadingText') {
>          this.isLoading =3D true
> -        $el.addClass(d).attr(d, d)
> +        $el.addClass(d).attr(d, d).prop(d, true)
>        } else if (this.isLoading) {
>          this.isLoading =3D false
> -        $el.removeClass(d).removeAttr(d)
> +        $el.removeClass(d).removeAttr(d).prop(d, false)
>        }
>      }, this), 0)
>    }
> @@ -281,10 +282,15 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>    $(document)
>      .on('click.bs.button.data-api', '[data-toggle^=3D"button"]', functio=
n
> (e) {
> -      var $btn =3D $(e.target)
> -      if (!$btn.hasClass('btn')) $btn =3D $btn.closest('.btn')
> +      var $btn =3D $(e.target).closest('.btn')
>        Plugin.call($btn, 'toggle')
> -      if (!($(e.target).is('input[type=3D"radio"]') ||
> $(e.target).is('input[type=3D"checkbox"]'))) e.preventDefault()
> +      if (!($(e.target).is('input[type=3D"radio"],
> input[type=3D"checkbox"]'))) {
> +        // Prevent double click on radios, and the double selections (so
> cancellation) on checkboxes
> +        e.preventDefault()
> +        // The target component still receive the focus
> +        if ($btn.is('input,button')) $btn.trigger('focus')
> +        else
> $btn.find('input:visible,button:visible').first().trigger('focus')
> +      }
>      })
>      .on('focus.bs.button.data-api blur.bs.button.data-api',
> '[data-toggle^=3D"button"]', function (e) {
>        $(e.target).closest('.btn').toggleClass('focus',
> /^focus(in)?$/.test(e.type))
> @@ -293,10 +299,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: carousel.js v3.3.6
> - * http://getbootstrap.com/javascript/#carousel
> + * Bootstrap: carousel.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#carousel
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -324,7 +330,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        .on('mouseleave.bs.carousel', $.proxy(this.cycle, this))
>    }
>
> -  Carousel.VERSION  =3D '3.3.6'
> +  Carousel.VERSION  =3D '3.4.1'
>
>    Carousel.TRANSITION_DURATION =3D 600
>
> @@ -438,7 +444,9 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      var slidEvent =3D $.Event('slid.bs.carousel', { relatedTarget:
> relatedTarget, direction: direction }) // yes, "slid"
>      if ($.support.transition && this.$element.hasClass('slide')) {
>        $next.addClass(type)
> -      $next[0].offsetWidth // force reflow
> +      if (typeof $next =3D=3D=3D 'object' && $next.length) {
> +        $next[0].offsetWidth // force reflow
> +      }
>        $active.addClass(direction)
>        $next.addClass(direction)
>        $active
> @@ -500,10 +508,17 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    var clickHandler =3D function (e) {
> -    var href
>      var $this   =3D $(this)
> -    var $target =3D $($this.attr('data-target') || (href =3D
> $this.attr('href')) && href.replace(/.*(?=3D#[^\s]+$)/, '')) // strip for=
 ie7
> +    var href    =3D $this.attr('href')
> +    if (href) {
> +      href =3D href.replace(/.*(?=3D#[^\s]+$)/, '') // strip for ie7
> +    }
> +
> +    var target  =3D $this.attr('data-target') || href
> +    var $target =3D $(document).find(target)
> +
>      if (!$target.hasClass('carousel')) return
> +
>      var options =3D $.extend({}, $target.data(), $this.data())
>      var slideIndex =3D $this.attr('data-slide-to')
>      if (slideIndex) options.interval =3D false
> @@ -531,13 +546,14 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: collapse.js v3.3.6
> - * http://getbootstrap.com/javascript/#collapse
> + * Bootstrap: collapse.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#collapse
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> +/* jshint latedef: false */
>
>  +function ($) {
>    'use strict';
> @@ -561,7 +577,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      if (this.options.toggle) this.toggle()
>    }
>
> -  Collapse.VERSION  =3D '3.3.6'
> +  Collapse.VERSION  =3D '3.4.1'
>
>    Collapse.TRANSITION_DURATION =3D 350
>
> @@ -668,7 +684,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    }
>
>    Collapse.prototype.getParent =3D function () {
> -    return $(this.options.parent)
> +    return $(document).find(this.options.parent)
>        .find('[data-toggle=3D"collapse"][data-parent=3D"' +
> this.options.parent + '"]')
>        .each($.proxy(function (i, element) {
>          var $element =3D $(element)
> @@ -691,7 +707,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      var target =3D $trigger.attr('data-target')
>        || (href =3D $trigger.attr('href')) && href.replace(/.*(?=3D#[^\s]=
+$)/,
> '') // strip for ie7
>
> -    return $(target)
> +    return $(document).find(target)
>    }
>
>
> @@ -743,10 +759,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: dropdown.js v3.3.6
> - * http://getbootstrap.com/javascript/#dropdowns
> + * Bootstrap: dropdown.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#dropdowns
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -763,7 +779,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      $(element).on('click.bs.dropdown', this.toggle)
>    }
>
> -  Dropdown.VERSION =3D '3.3.6'
> +  Dropdown.VERSION =3D '3.4.1'
>
>    function getParent($this) {
>      var selector =3D $this.attr('data-target')
> @@ -773,7 +789,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        selector =3D selector && /#[A-Za-z]/.test(selector) &&
> selector.replace(/.*(?=3D#[^\s]*$)/, '') // strip for ie7
>      }
>
> -    var $parent =3D selector && $(selector)
> +    var $parent =3D selector !=3D=3D '#' ? $(document).find(selector) : =
null
>
>      return $parent && $parent.length ? $parent : $this.parent()
>    }
> @@ -909,10 +925,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: modal.js v3.3.6
> - * http://getbootstrap.com/javascript/#modals
> + * Bootstrap: modal.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#modals
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -924,15 +940,16 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    var Modal =3D function (element, options) {
> -    this.options             =3D options
> -    this.$body               =3D $(document.body)
> -    this.$element            =3D $(element)
> -    this.$dialog             =3D this.$element.find('.modal-dialog')
> -    this.$backdrop           =3D null
> -    this.isShown             =3D null
> -    this.originalBodyPad     =3D null
> -    this.scrollbarWidth      =3D 0
> +    this.options =3D options
> +    this.$body =3D $(document.body)
> +    this.$element =3D $(element)
> +    this.$dialog =3D this.$element.find('.modal-dialog')
> +    this.$backdrop =3D null
> +    this.isShown =3D null
> +    this.originalBodyPad =3D null
> +    this.scrollbarWidth =3D 0
>      this.ignoreBackdropClick =3D false
> +    this.fixedContent =3D '.navbar-fixed-top, .navbar-fixed-bottom'
>
>      if (this.options.remote) {
>        this.$element
> @@ -943,7 +960,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      }
>    }
>
> -  Modal.VERSION  =3D '3.3.6'
> +  Modal.VERSION =3D '3.4.1'
>
>    Modal.TRANSITION_DURATION =3D 300
>    Modal.BACKDROP_TRANSITION_DURATION =3D 150
> @@ -960,7 +977,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>    Modal.prototype.show =3D function (_relatedTarget) {
>      var that =3D this
> -    var e    =3D $.Event('show.bs.modal', { relatedTarget: _relatedTarge=
t })
> +    var e =3D $.Event('show.bs.modal', { relatedTarget: _relatedTarget }=
)
>
>      this.$element.trigger(e)
>
> @@ -1050,7 +1067,9 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      $(document)
>        .off('focusin.bs.modal') // guard against infinite focus loop
>        .on('focusin.bs.modal', $.proxy(function (e) {
> -        if (this.$element[0] !=3D=3D e.target &&
> !this.$element.has(e.target).length) {
> +        if (document !=3D=3D e.target &&
> +          this.$element[0] !=3D=3D e.target &&
> +          !this.$element.has(e.target).length) {
>            this.$element.trigger('focus')
>          }
>        }, this))
> @@ -1152,7 +1171,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      var modalIsOverflowing =3D this.$element[0].scrollHeight >
> document.documentElement.clientHeight
>
>      this.$element.css({
> -      paddingLeft:  !this.bodyIsOverflowing && modalIsOverflowing ?
> this.scrollbarWidth : '',
> +      paddingLeft: !this.bodyIsOverflowing && modalIsOverflowing ?
> this.scrollbarWidth : '',
>        paddingRight: this.bodyIsOverflowing && !modalIsOverflowing ?
> this.scrollbarWidth : ''
>      })
>    }
> @@ -1177,11 +1196,26 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    Modal.prototype.setScrollbar =3D function () {
>      var bodyPad =3D parseInt((this.$body.css('padding-right') || 0), 10)
>      this.originalBodyPad =3D document.body.style.paddingRight || ''
> -    if (this.bodyIsOverflowing) this.$body.css('padding-right', bodyPad =
+
> this.scrollbarWidth)
> +    var scrollbarWidth =3D this.scrollbarWidth
> +    if (this.bodyIsOverflowing) {
> +      this.$body.css('padding-right', bodyPad + scrollbarWidth)
> +      $(this.fixedContent).each(function (index, element) {
> +        var actualPadding =3D element.style.paddingRight
> +        var calculatedPadding =3D $(element).css('padding-right')
> +        $(element)
> +          .data('padding-right', actualPadding)
> +          .css('padding-right', parseFloat(calculatedPadding) +
> scrollbarWidth + 'px')
> +      })
> +    }
>    }
>
>    Modal.prototype.resetScrollbar =3D function () {
>      this.$body.css('padding-right', this.originalBodyPad)
> +    $(this.fixedContent).each(function (index, element) {
> +      var padding =3D $(element).data('padding-right')
> +      $(element).removeData('padding-right')
> +      element.style.paddingRight =3D padding ? padding : ''
> +    })
>    }
>
>    Modal.prototype.measureScrollbar =3D function () { // thx walsh
> @@ -1199,8 +1233,8 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>    function Plugin(option, _relatedTarget) {
>      return this.each(function () {
> -      var $this   =3D $(this)
> -      var data    =3D $this.data('bs.modal')
> +      var $this =3D $(this)
> +      var data =3D $this.data('bs.modal')
>        var options =3D $.extend({}, Modal.DEFAULTS, $this.data(), typeof
> option =3D=3D 'object' && option)
>
>        if (!data) $this.data('bs.modal', (data =3D new Modal(this, option=
s)))
> @@ -1211,7 +1245,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>    var old =3D $.fn.modal
>
> -  $.fn.modal             =3D Plugin
> +  $.fn.modal =3D Plugin
>    $.fn.modal.Constructor =3D Modal
>
>
> @@ -1228,10 +1262,13 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    $(document).on('click.bs.modal.data-api', '[data-toggle=3D"modal"]',
> function (e) {
> -    var $this   =3D $(this)
> -    var href    =3D $this.attr('href')
> -    var $target =3D $($this.attr('data-target') || (href &&
> href.replace(/.*(?=3D#[^\s]+$)/, ''))) // strip for ie7
> -    var option  =3D $target.data('bs.modal') ? 'toggle' : $.extend({
> remote: !/#/.test(href) && href }, $target.data(), $this.data())
> +    var $this =3D $(this)
> +    var href =3D $this.attr('href')
> +    var target =3D $this.attr('data-target') ||
> +      (href && href.replace(/.*(?=3D#[^\s]+$)/, '')) // strip for ie7
> +
> +    var $target =3D $(document).find(target)
> +    var option =3D $target.data('bs.modal') ? 'toggle' : $.extend({ remo=
te:
> !/#/.test(href) && href }, $target.data(), $this.data())
>
>      if ($this.is('a')) e.preventDefault()
>
> @@ -1247,18 +1284,148 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: tooltip.js v3.3.6
> - * http://getbootstrap.com/javascript/#tooltip
> + * Bootstrap: tooltip.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#tooltip
>   * Inspired by the original jQuery.tipsy by Jason Frame
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> -
>  +function ($) {
>    'use strict';
>
> +  var DISALLOWED_ATTRIBUTES =3D ['sanitize', 'whiteList', 'sanitizeFn']
> +
> +  var uriAttrs =3D [
> +    'background',
> +    'cite',
> +    'href',
> +    'itemtype',
> +    'longdesc',
> +    'poster',
> +    'src',
> +    'xlink:href'
> +  ]
> +
> +  var ARIA_ATTRIBUTE_PATTERN =3D /^aria-[\w-]*$/i
> +
> +  var DefaultWhitelist =3D {
> +    // Global attributes allowed on any supplied element below.
> +    '*': ['class', 'dir', 'id', 'lang', 'role', ARIA_ATTRIBUTE_PATTERN],
> +    a: ['target', 'href', 'title', 'rel'],
> +    area: [],
> +    b: [],
> +    br: [],
> +    col: [],
> +    code: [],
> +    div: [],
> +    em: [],
> +    hr: [],
> +    h1: [],
> +    h2: [],
> +    h3: [],
> +    h4: [],
> +    h5: [],
> +    h6: [],
> +    i: [],
> +    img: ['src', 'alt', 'title', 'width', 'height'],
> +    li: [],
> +    ol: [],
> +    p: [],
> +    pre: [],
> +    s: [],
> +    small: [],
> +    span: [],
> +    sub: [],
> +    sup: [],
> +    strong: [],
> +    u: [],
> +    ul: []
> +  }
> +
> +  /**
> +   * A pattern that recognizes a commonly useful subset of URLs that are
> safe.
> +   *
> +   * Shoutout to Angular 7
> https://github.com/angular/angular/blob/7.2.4/packages/core/src/sanitizat=
ion/url_sanitizer.ts
> +   */
> +  var SAFE_URL_PATTERN =3D
> /^(?:(?:https?|mailto|ftp|tel|file):|[^&:/?#]*(?:[/?#]|$))/gi
> +
> +  /**
> +   * A pattern that matches safe data URLs. Only matches image, video an=
d
> audio types.
> +   *
> +   * Shoutout to Angular 7
> https://github.com/angular/angular/blob/7.2.4/packages/core/src/sanitizat=
ion/url_sanitizer.ts
> +   */
> +  var DATA_URL_PATTERN =3D
> /^data:(?:image\/(?:bmp|gif|jpeg|jpg|png|tiff|webp)|video\/(?:mpeg|mp4|og=
g|webm)|audio\/(?:mp3|oga|ogg|opus));base64,[a-z0-9+/]+=3D*$/i
> +
> +  function allowedAttribute(attr, allowedAttributeList) {
> +    var attrName =3D attr.nodeName.toLowerCase()
> +
> +    if ($.inArray(attrName, allowedAttributeList) !=3D=3D -1) {
> +      if ($.inArray(attrName, uriAttrs) !=3D=3D -1) {
> +        return Boolean(attr.nodeValue.match(SAFE_URL_PATTERN) ||
> attr.nodeValue.match(DATA_URL_PATTERN))
> +      }
> +
> +      return true
> +    }
> +
> +    var regExp =3D $(allowedAttributeList).filter(function (index, value=
) {
> +      return value instanceof RegExp
> +    })
> +
> +    // Check if a regular expression validates the attribute.
> +    for (var i =3D 0, l =3D regExp.length; i < l; i++) {
> +      if (attrName.match(regExp[i])) {
> +        return true
> +      }
> +    }
> +
> +    return false
> +  }
> +
> +  function sanitizeHtml(unsafeHtml, whiteList, sanitizeFn) {
> +    if (unsafeHtml.length =3D=3D=3D 0) {
> +      return unsafeHtml
> +    }
> +
> +    if (sanitizeFn && typeof sanitizeFn =3D=3D=3D 'function') {
> +      return sanitizeFn(unsafeHtml)
> +    }
> +
> +    // IE 8 and below don't support createHTMLDocument
> +    if (!document.implementation ||
> !document.implementation.createHTMLDocument) {
> +      return unsafeHtml
> +    }
> +
> +    var createdDocument =3D
> document.implementation.createHTMLDocument('sanitization')
> +    createdDocument.body.innerHTML =3D unsafeHtml
> +
> +    var whitelistKeys =3D $.map(whiteList, function (el, i) { return i }=
)
> +    var elements =3D $(createdDocument.body).find('*')
> +
> +    for (var i =3D 0, len =3D elements.length; i < len; i++) {
> +      var el =3D elements[i]
> +      var elName =3D el.nodeName.toLowerCase()
> +
> +      if ($.inArray(elName, whitelistKeys) =3D=3D=3D -1) {
> +        el.parentNode.removeChild(el)
> +
> +        continue
> +      }
> +
> +      var attributeList =3D $.map(el.attributes, function (el) { return =
el
> })
> +      var whitelistedAttributes =3D [].concat(whiteList['*'] || [],
> whiteList[elName] || [])
> +
> +      for (var j =3D 0, len2 =3D attributeList.length; j < len2; j++) {
> +        if (!allowedAttribute(attributeList[j], whitelistedAttributes)) =
{
> +          el.removeAttribute(attributeList[j].nodeName)
> +        }
> +      }
> +    }
> +
> +    return createdDocument.body.innerHTML
> +  }
> +
>    // TOOLTIP PUBLIC CLASS DEFINITION
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -1274,7 +1441,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      this.init('tooltip', element, options)
>    }
>
> -  Tooltip.VERSION  =3D '3.3.6'
> +  Tooltip.VERSION  =3D '3.4.1'
>
>    Tooltip.TRANSITION_DURATION =3D 150
>
> @@ -1291,7 +1458,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      viewport: {
>        selector: 'body',
>        padding: 0
> -    }
> +    },
> +    sanitize : true,
> +    sanitizeFn : null,
> +    whiteList : DefaultWhitelist
>    }
>
>    Tooltip.prototype.init =3D function (type, element, options) {
> @@ -1299,7 +1469,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      this.type      =3D type
>      this.$element  =3D $(element)
>      this.options   =3D this.getOptions(options)
> -    this.$viewport =3D this.options.viewport &&
> $($.isFunction(this.options.viewport) ? this.options.viewport.call(this,
> this.$element) : (this.options.viewport.selector || this.options.viewport=
))
> +    this.$viewport =3D this.options.viewport &&
> $(document).find($.isFunction(this.options.viewport) ?
> this.options.viewport.call(this, this.$element) :
> (this.options.viewport.selector || this.options.viewport))
>      this.inState   =3D { click: false, hover: false, focus: false }
>
>      if (this.$element[0] instanceof document.constructor &&
> !this.options.selector) {
> @@ -1332,7 +1502,15 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    }
>
>    Tooltip.prototype.getOptions =3D function (options) {
> -    options =3D $.extend({}, this.getDefaults(), this.$element.data(),
> options)
> +    var dataAttributes =3D this.$element.data()
> +
> +    for (var dataAttr in dataAttributes) {
> +      if (dataAttributes.hasOwnProperty(dataAttr) && $.inArray(dataAttr,
> DISALLOWED_ATTRIBUTES) !=3D=3D -1) {
> +        delete dataAttributes[dataAttr]
> +      }
> +    }
> +
> +    options =3D $.extend({}, this.getDefaults(), dataAttributes, options=
)
>
>      if (options.delay && typeof options.delay =3D=3D 'number') {
>        options.delay =3D {
> @@ -1341,6 +1519,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        }
>      }
>
> +    if (options.sanitize) {
> +      options.template =3D sanitizeHtml(options.template,
> options.whiteList, options.sanitizeFn)
> +    }
> +
>      return options
>    }
>
> @@ -1452,7 +1634,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>          .addClass(placement)
>          .data('bs.' + this.type, this)
>
> -      this.options.container ? $tip.appendTo(this.options.container) :
> $tip.insertAfter(this.$element)
> +      this.options.container ?
> $tip.appendTo($(document).find(this.options.container)) :
> $tip.insertAfter(this.$element)
>        this.$element.trigger('inserted.bs.' + this.type)
>
>        var pos          =3D this.getPosition()
> @@ -1554,7 +1736,16 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      var $tip  =3D this.tip()
>      var title =3D this.getTitle()
>
> -    $tip.find('.tooltip-inner')[this.options.html ? 'html' :
> 'text'](title)
> +    if (this.options.html) {
> +      if (this.options.sanitize) {
> +        title =3D sanitizeHtml(title, this.options.whiteList,
> this.options.sanitizeFn)
> +      }
> +
> +      $tip.find('.tooltip-inner').html(title)
> +    } else {
> +      $tip.find('.tooltip-inner').text(title)
> +    }
> +
>      $tip.removeClass('fade in top bottom left right')
>    }
>
> @@ -1565,9 +1756,11 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>      function complete() {
>        if (that.hoverState !=3D 'in') $tip.detach()
> -      that.$element
> -        .removeAttr('aria-describedby')
> -        .trigger('hidden.bs.' + that.type)
> +      if (that.$element) { // TODO: Check whether guarding this code wit=
h
> this `if` is really necessary.
> +        that.$element
> +          .removeAttr('aria-describedby')
> +          .trigger('hidden.bs.' + that.type)
> +      }
>        callback && callback()
>      }
>
> @@ -1610,7 +1803,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        // width and height are missing in IE8, so compute them manually;
> see https://github.com/twbs/bootstrap/issues/14093
>        elRect =3D $.extend({}, elRect, { width: elRect.right - elRect.lef=
t,
> height: elRect.bottom - elRect.top })
>      }
> -    var elOffset  =3D isBody ? { top: 0, left: 0 } : $element.offset()
> +    var isSvg =3D window.SVGElement && el instanceof window.SVGElement
> +    // Avoid using $.offset() on SVGs since it gives incorrect results i=
n
> jQuery 3.
> +    // See https://github.com/twbs/bootstrap/issues/20280
> +    var elOffset  =3D isBody ? { top: 0, left: 0 } : (isSvg ? null :
> $element.offset())
>      var scroll    =3D { scroll: isBody ? document.documentElement.scroll=
Top
> || document.body.scrollTop : $element.scrollTop() }
>      var outerDims =3D isBody ? { width: $(window).width(), height:
> $(window).height() } : null
>
> @@ -1726,9 +1922,13 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        that.$tip =3D null
>        that.$arrow =3D null
>        that.$viewport =3D null
> +      that.$element =3D null
>      })
>    }
>
> +  Tooltip.prototype.sanitizeHtml =3D function (unsafeHtml) {
> +    return sanitizeHtml(unsafeHtml, this.options.whiteList,
> this.options.sanitizeFn)
> +  }
>
>    // TOOLTIP PLUGIN DEFINITION
>    // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> @@ -1762,10 +1962,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: popover.js v3.3.6
> - * http://getbootstrap.com/javascript/#popovers
> + * Bootstrap: popover.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#popovers
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -1782,7 +1982,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>    if (!$.fn.tooltip) throw new Error('Popover requires tooltip.js')
>
> -  Popover.VERSION  =3D '3.3.6'
> +  Popover.VERSION  =3D '3.4.1'
>
>    Popover.DEFAULTS =3D $.extend({}, $.fn.tooltip.Constructor.DEFAULTS, {
>      placement: 'right',
> @@ -1808,10 +2008,25 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      var title   =3D this.getTitle()
>      var content =3D this.getContent()
>
> -    $tip.find('.popover-title')[this.options.html ? 'html' :
> 'text'](title)
> -    $tip.find('.popover-content').children().detach().end()[ // we use
> append for html objects to maintain js events
> -      this.options.html ? (typeof content =3D=3D 'string' ? 'html' :
> 'append') : 'text'
> -    ](content)
> +    if (this.options.html) {
> +      var typeContent =3D typeof content
> +
> +      if (this.options.sanitize) {
> +        title =3D this.sanitizeHtml(title)
> +
> +        if (typeContent =3D=3D=3D 'string') {
> +          content =3D this.sanitizeHtml(content)
> +        }
> +      }
> +
> +      $tip.find('.popover-title').html(title)
> +      $tip.find('.popover-content').children().detach().end()[
> +        typeContent =3D=3D=3D 'string' ? 'html' : 'append'
> +      ](content)
> +    } else {
> +      $tip.find('.popover-title').text(title)
> +
> $tip.find('.popover-content').children().detach().end().text(content)
> +    }
>
>      $tip.removeClass('fade top bottom left right in')
>
> @@ -1830,8 +2045,8 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>      return $e.attr('data-content')
>        || (typeof o.content =3D=3D 'function' ?
> -            o.content.call($e[0]) :
> -            o.content)
> +        o.content.call($e[0]) :
> +        o.content)
>    }
>
>    Popover.prototype.arrow =3D function () {
> @@ -1871,10 +2086,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: scrollspy.js v3.3.6
> - * http://getbootstrap.com/javascript/#scrollspy
> + * Bootstrap: scrollspy.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#scrollspy
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -1900,7 +2115,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      this.process()
>    }
>
> -  ScrollSpy.VERSION  =3D '3.3.6'
> +  ScrollSpy.VERSION  =3D '3.4.1'
>
>    ScrollSpy.DEFAULTS =3D {
>      offset: 10
> @@ -2044,10 +2259,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: tab.js v3.3.6
> - * http://getbootstrap.com/javascript/#tabs
> + * Bootstrap: tab.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#tabs
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -2064,7 +2279,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      // jscs:enable requireDollarBeforejQueryAssignment
>    }
>
> -  Tab.VERSION =3D '3.3.6'
> +  Tab.VERSION =3D '3.4.1'
>
>    Tab.TRANSITION_DURATION =3D 150
>
> @@ -2093,7 +2308,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>
>      if (showEvent.isDefaultPrevented() || hideEvent.isDefaultPrevented()=
)
> return
>
> -    var $target =3D $(selector)
> +    var $target =3D $(document).find(selector)
>
>      this.activate($this.closest('li'), $ul)
>      this.activate($target, $target.parent(), function () {
> @@ -2118,15 +2333,15 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        $active
>          .removeClass('active')
>          .find('> .dropdown-menu > .active')
> -          .removeClass('active')
> +        .removeClass('active')
>          .end()
>          .find('[data-toggle=3D"tab"]')
> -          .attr('aria-expanded', false)
> +        .attr('aria-expanded', false)
>
>        element
>          .addClass('active')
>          .find('[data-toggle=3D"tab"]')
> -          .attr('aria-expanded', true)
> +        .attr('aria-expanded', true)
>
>        if (transition) {
>          element[0].offsetWidth // reflow for transition
> @@ -2138,10 +2353,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>        if (element.parent('.dropdown-menu').length) {
>          element
>            .closest('li.dropdown')
> -            .addClass('active')
> +          .addClass('active')
>            .end()
>            .find('[data-toggle=3D"tab"]')
> -            .attr('aria-expanded', true)
> +          .attr('aria-expanded', true)
>        }
>
>        callback && callback()
> @@ -2200,10 +2415,10 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>  }(jQuery);
>
>  /*
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Bootstrap: affix.js v3.3.6
> - * http://getbootstrap.com/javascript/#affix
> + * Bootstrap: affix.js v3.4.1
> + * https://getbootstrap.com/docs/3.4/javascript/#affix
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * Copyright 2011-2015 Twitter, Inc.
> + * Copyright 2011-2019 Twitter, Inc.
>   * Licensed under MIT (
> https://github.com/twbs/bootstrap/blob/master/LICENSE)
>   *
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>
> @@ -2217,7 +2432,9 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>    var Affix =3D function (element, options) {
>      this.options =3D $.extend({}, Affix.DEFAULTS, options)
>
> -    this.$target =3D $(this.options.target)
> +    var target =3D this.options.target =3D=3D=3D Affix.DEFAULTS.target ?
> $(this.options.target) : $(document).find(this.options.target)
> +
> +    this.$target =3D target
>        .on('scroll.bs.affix.data-api', $.proxy(this.checkPosition, this))
>        .on('click.bs.affix.data-api',
> $.proxy(this.checkPositionWithEventLoop, this))
>
> @@ -2229,7 +2446,7 @@ if (typeof jQuery =3D=3D=3D 'undefined') {
>      this.checkPosition()
>    }
>
> -  Affix.VERSION  =3D '3.3.6'
> +  Affix.VERSION  =3D '3.4.1'
>
>    Affix.RESET    =3D 'affix affix-top affix-bottom'
>
> diff --git a/lib/toaster/toastergui/static/js/bootstrap-3.4.1.min.js
> b/lib/toaster/toastergui/static/js/bootstrap-3.4.1.min.js
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..eb0a8b410f59eb8abcd21e588f1a7b7=
18db3eebd
> GIT binary patch
> literal 39680
> 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
c4a
> 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
=3D`
> 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
> B&G`TT
>
> literal 0
> HcmV?d00001
>
> diff --git a/lib/toaster/toastergui/static/js/bootstrap.min.js
> b/lib/toaster/toastergui/static/js/bootstrap.min.js
> deleted file mode 100644
> index
> 2446398cfe6177172771488ec9bbef5429050afd..0000000000000000000000000000000=
000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 37049
> 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
k
> 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
d
> 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
> X12l9U@Q92=3D*7GQe1K@g9>*W6dNOSnh
>
> diff --git a/lib/toaster/toastergui/templates/base.html
> b/lib/toaster/toastergui/templates/base.html
> index 709573dd..e8600f3e 100644
> --- a/lib/toaster/toastergui/templates/base.html
> +++ b/lib/toaster/toastergui/templates/base.html
> @@ -18,7 +18,7 @@
>      </script>
>      <script src=3D"{% static 'js/jquery.cookie.js' %}">
>      </script>
> -    <script src=3D"{% static 'js/bootstrap.min.js' %}">
> +    <script src=3D"{% static 'js/bootstrap-3.4.1.min.js' %}">
>      </script>
>      <script src=3D"{% static 'js/typeahead.jquery.js' %}">
>      </script>
> diff --git a/lib/toaster/toastergui/templates/base_specific.html
> b/lib/toaster/toastergui/templates/base_specific.html
> index e377cadd..425f7ed7 100644
> --- a/lib/toaster/toastergui/templates/base_specific.html
> +++ b/lib/toaster/toastergui/templates/base_specific.html
> @@ -14,11 +14,11 @@
>
>      <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-sca=
le=3D1.0"
> />
>      <meta http-equiv=3D"Content-Type" content=3D"text/html;charset=3DUTF=
-8" />
> -    <script src=3D"{% static 'js/jquery-2.0.3.min.js' %}">
> +    <script src=3D"{% static 'js/jquery-3.7.1.min.js' %}">
>      </script>
>      <script src=3D"{% static 'js/jquery.cookie.js' %}">
>      </script>
> -    <script src=3D"{% static 'js/bootstrap.min.js' %}">
> +    <script src=3D"{% static 'js/bootstrap-3.4.1.min.js' %}">
>      </script>
>      <script src=3D"{% static 'js/typeahead.jquery.js' %}">
>      </script>
> diff --git a/lib/toaster/toastergui/templates/js-unit-tests.html
> b/lib/toaster/toastergui/templates/js-unit-tests.html
> index ca248962..41553c4f 100644
> --- a/lib/toaster/toastergui/templates/js-unit-tests.html
> +++ b/lib/toaster/toastergui/templates/js-unit-tests.html
> @@ -11,7 +11,7 @@
>  <script src=3D"{% static 'js/layerDepsModal.js' %}"></script>
>  <script src=3D"{% static 'js/projectpage.js' %}"></script>
>
> -<script src=3D"{% static 'js/bootstrap.min.js' %}"></script>
> +<script src=3D"{% static 'js/bootstrap-3.4.1.min.js' %}"></script>
>  <script src=3D"{% static 'js/filtersnippet.js' %}"></script>
>  <script src=3D"{% static 'js/importlayer.js' %}"></script>
>  <script src=3D"{% static 'js/highlight.pack.js' %}"></script>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15244):
> https://lists.openembedded.org/g/bitbake-devel/message/15244
> Mute This Topic: https://lists.openembedded.org/mt/101998960/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000002879640607dc2d7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 16, 2023 at 9:04=E2=80=AF=
AM Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodriguez-garcia@sa=
voirfairelinux.com">marlon.rodriguez-garcia@savoirfairelinux.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Update boot=
strap version to 3.4.1 to fix incompatibility issues and security vulnerabi=
lities<br></blockquote><div><br></div><div>The link to the nvd vulnerabilit=
ies that I included in the review would be helpful here but I&#39;ll let it=
 go.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
Files base, base_specific and js-unit-test were updated to match new versio=
ns of files<br>
<br>
Changes in v2:<br>
Update bootstrap version from 3.3.7 to 3.4.1 and explicit name version in f=
iles<br>
<br></blockquote><div>&quot;Changes in v2&quot;=C2=A0belongs below the --- =
line (which is right after your Signed-off-by: in the email patch) as it is=
 part of the review and we do not want it in the final git history.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodrigu=
ez-garcia@savoirfairelinux.com" target=3D"_blank">marlon.rodriguez-garcia@s=
avoirfairelinux.com</a>&gt;<br></blockquote><div>Reviewed-by: Tim Orling &l=
t;<a href=3D"mailto:tim.orling@konsulko.com">tim.orling@konsulko.com</a>&gt=
;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0.../js/{bootstrap.js =3D&gt; bootstrap-3.4.1.js}=C2=A0 =C2=A0| 431 ++=
+++++++++++-----<br>
=C2=A0.../static/js/bootstrap-3.4.1.min.js=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | Bin 0 -&gt; 39680 bytes<br>
=C2=A0.../toastergui/static/js/bootstrap.min.js=C2=A0 =C2=A0 =C2=A0| Bin 37=
049 -&gt; 0 bytes<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
=C2=A0.../toastergui/templates/base_specific.html=C2=A0 =C2=A0|=C2=A0 =C2=
=A04 +-<br>
=C2=A0.../toastergui/templates/js-unit-tests.html=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A06 files changed, 328 insertions(+), 111 deletions(-)<br>
=C2=A0rename lib/toaster/toastergui/static/js/{bootstrap.js =3D&gt; bootstr=
ap-3.4.1.js} (84%)<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/bootstrap-3.4.1.m=
in.js<br>
=C2=A0delete mode 100644 lib/toaster/toastergui/static/js/bootstrap.min.js<=
br>
<br>
diff --git a/lib/toaster/toastergui/static/js/bootstrap.js b/lib/toaster/to=
astergui/static/js/bootstrap-3.4.1.js<br>
similarity index 84%<br>
rename from lib/toaster/toastergui/static/js/bootstrap.js<br>
rename to lib/toaster/toastergui/static/js/bootstrap-3.4.1.js<br>
index d47d640f..170bd608 100644<br>
--- a/lib/toaster/toastergui/static/js/bootstrap.js<br>
+++ b/lib/toaster/toastergui/static/js/bootstrap-3.4.1.js<br>
@@ -1,6 +1,6 @@<br>
=C2=A0/*!<br>
- * Bootstrap v3.3.6 (<a href=3D"http://getbootstrap.com" rel=3D"noreferrer=
" target=3D"_blank">http://getbootstrap.com</a>)<br>
- * Copyright 2011-2016 Twitter, Inc.<br>
+ * Bootstrap v3.4.1 (<a href=3D"https://getbootstrap.com/" rel=3D"noreferr=
er" target=3D"_blank">https://getbootstrap.com/</a>)<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under the MIT license<br>
=C2=A0 */<br>
<br>
@@ -11,16 +11,16 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0+function ($) {<br>
=C2=A0 =C2=A0&#39;use strict&#39;;<br>
=C2=A0 =C2=A0var version =3D $.fn.jquery.split(&#39; &#39;)[0].split(&#39;.=
&#39;)<br>
-=C2=A0 if ((version[0] &lt; 2 &amp;&amp; version[1] &lt; 9) || (version[0]=
 =3D=3D 1 &amp;&amp; version[1] =3D=3D 9 &amp;&amp; version[2] &lt; 1) || (=
version[0] &gt; 2)) {<br>
-=C2=A0 =C2=A0 throw new Error(&#39;Bootstrap\&#39;s JavaScript requires jQ=
uery version 1.9.1 or higher, but lower than version 3&#39;)<br>
+=C2=A0 if ((version[0] &lt; 2 &amp;&amp; version[1] &lt; 9) || (version[0]=
 =3D=3D 1 &amp;&amp; version[1] =3D=3D 9 &amp;&amp; version[2] &lt; 1) || (=
version[0] &gt; 3)) {<br>
+=C2=A0 =C2=A0 throw new Error(&#39;Bootstrap\&#39;s JavaScript requires jQ=
uery version 1.9.1 or higher, but lower than version 4&#39;)<br>
=C2=A0 =C2=A0}<br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: transition.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#transitions" rel=3D"nore=
ferrer" target=3D"_blank">http://getbootstrap.com/javascript/#transitions</=
a><br>
+ * Bootstrap: transition.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#transitions" r=
el=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javas=
cript/#transitions</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -28,7 +28,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0+function ($) {<br>
=C2=A0 =C2=A0&#39;use strict&#39;;<br>
<br>
-=C2=A0 // CSS TRANSITION SUPPORT (Shoutout: <a href=3D"http://www.moderniz=
r.com/" rel=3D"noreferrer" target=3D"_blank">http://www.modernizr.com/</a>)=
<br>
+=C2=A0 // CSS TRANSITION SUPPORT (Shoutout: <a href=3D"https://modernizr.c=
om/" rel=3D"noreferrer" target=3D"_blank">https://modernizr.com/</a>)<br>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 =C2=A0function transitionEnd() {<br>
@@ -50,7 +50,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0return false // explicit for ie8 (=C2=A0 ._.)<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 // <a href=3D"http://blog.alexmaccaw.com/css-transitions" rel=3D"no=
referrer" target=3D"_blank">http://blog.alexmaccaw.com/css-transitions</a><=
br>
+=C2=A0 // <a href=3D"https://blog.alexmaccaw.com/css-transitions" rel=3D"n=
oreferrer" target=3D"_blank">https://blog.alexmaccaw.com/css-transitions</a=
><br>
=C2=A0 =C2=A0$.fn.emulateTransitionEnd =3D function (duration) {<br>
=C2=A0 =C2=A0 =C2=A0var called =3D false<br>
=C2=A0 =C2=A0 =C2=A0var $el =3D this<br>
@@ -77,10 +77,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: alert.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#alerts" rel=3D"noreferre=
r" target=3D"_blank">http://getbootstrap.com/javascript/#alerts</a><br>
+ * Bootstrap: alert.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#alerts" rel=3D=
"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascript=
/#alerts</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -96,7 +96,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0$(el).on(&#39;click&#39;, dismiss, this.close)<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Alert.VERSION =3D &#39;3.3.6&#39;<br>
+=C2=A0 Alert.VERSION =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Alert.TRANSITION_DURATION =3D 150<br>
<br>
@@ -109,7 +109,8 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D selector &amp;&amp; selector.replac=
e(/.*(?=3D#[^\s]*$)/, &#39;&#39;) // strip for ie7<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 var $parent =3D $(selector)<br>
+=C2=A0 =C2=A0 selector=C2=A0 =C2=A0 =3D selector =3D=3D=3D &#39;#&#39; ? [=
] : selector<br>
+=C2=A0 =C2=A0 var $parent =3D $(document).find(selector)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (e) e.preventDefault()<br>
<br>
@@ -172,10 +173,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: button.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#buttons" rel=3D"noreferr=
er" target=3D"_blank">http://getbootstrap.com/javascript/#buttons</a><br>
+ * Bootstrap: button.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#buttons" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#buttons</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -192,7 +193,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0this.isLoading =3D false<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Button.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Button.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Button.DEFAULTS =3D {<br>
=C2=A0 =C2=A0 =C2=A0loadingText: &#39;loading...&#39;<br>
@@ -214,10 +215,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (state =3D=3D &#39;loadingText&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this.isLoading =3D true<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 $el.addClass(d).attr(d, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $el.addClass(d).attr(d, d).prop(d, true)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (this.isLoading) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this.isLoading =3D false<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 $el.removeClass(d).removeAttr(d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $el.removeClass(d).removeAttr(d).prop(d, false=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}, this), 0)<br>
=C2=A0 =C2=A0}<br>
@@ -281,10 +282,15 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0$(document)<br>
=C2=A0 =C2=A0 =C2=A0.on(&#39;click.bs.button.data-api&#39;, &#39;[data-togg=
le^=3D&quot;button&quot;]&#39;, function (e) {<br>
-=C2=A0 =C2=A0 =C2=A0 var $btn =3D $(e.target)<br>
-=C2=A0 =C2=A0 =C2=A0 if (!$btn.hasClass(&#39;btn&#39;)) $btn =3D $btn.clos=
est(&#39;.btn&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 var $btn =3D $(e.target).closest(&#39;.btn&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Plugin.call($btn, &#39;toggle&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 if (!($(e.target).is(&#39;input[type=3D&quot;radio&qu=
ot;]&#39;) || $(e.target).is(&#39;input[type=3D&quot;checkbox&quot;]&#39;))=
) e.preventDefault()<br>
+=C2=A0 =C2=A0 =C2=A0 if (!($(e.target).is(&#39;input[type=3D&quot;radio&qu=
ot;], input[type=3D&quot;checkbox&quot;]&#39;))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Prevent double click on radios, and the dou=
ble selections (so cancellation) on checkboxes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e.preventDefault()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // The target component still receive the focu=
s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($<a href=3D"http://btn.is" rel=3D"noreferr=
er" target=3D"_blank">btn.is</a>(&#39;input,button&#39;)) $btn.trigger(&#39=
;focus&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else $btn.find(&#39;input:visible,button:visib=
le&#39;).first().trigger(&#39;focus&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0})<br>
=C2=A0 =C2=A0 =C2=A0.on(&#39;focus.bs.button.data-api blur.bs.button.data-a=
pi&#39;, &#39;[data-toggle^=3D&quot;button&quot;]&#39;, function (e) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(e.target).closest(&#39;.btn&#39;).toggleClass(=
&#39;focus&#39;, /^focus(in)?$/.test(e.type))<br>
@@ -293,10 +299,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: carousel.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#carousel" rel=3D"norefer=
rer" target=3D"_blank">http://getbootstrap.com/javascript/#carousel</a><br>
+ * Bootstrap: carousel.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#carousel" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#carousel</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -324,7 +330,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.on(&#39;mouseleave.bs.carousel&#39;, $.proxy(th=
is.cycle, this))<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Carousel.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Carousel.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Carousel.TRANSITION_DURATION =3D 600<br>
<br>
@@ -438,7 +444,9 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0var slidEvent =3D $.Event(&#39;slid.bs.carousel&#39;, {=
 relatedTarget: relatedTarget, direction: direction }) // yes, &quot;slid&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0if ($.support.transition &amp;&amp; this.$element.hasCl=
ass(&#39;slide&#39;)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$next.addClass(type)<br>
-=C2=A0 =C2=A0 =C2=A0 $next[0].offsetWidth // force reflow<br>
+=C2=A0 =C2=A0 =C2=A0 if (typeof $next =3D=3D=3D &#39;object&#39; &amp;&amp=
; $next.length) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $next[0].offsetWidth // force reflow<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$active.addClass(direction)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$next.addClass(direction)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$active<br>
@@ -500,10 +508,17 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 =C2=A0var clickHandler =3D function (e) {<br>
-=C2=A0 =C2=A0 var href<br>
=C2=A0 =C2=A0 =C2=A0var $this=C2=A0 =C2=A0=3D $(this)<br>
-=C2=A0 =C2=A0 var $target =3D $($this.attr(&#39;data-target&#39;) || (href=
 =3D $this.attr(&#39;href&#39;)) &amp;&amp; href.replace(/.*(?=3D#[^\s]+$)/=
, &#39;&#39;)) // strip for ie7<br>
+=C2=A0 =C2=A0 var href=C2=A0 =C2=A0 =3D $this.attr(&#39;href&#39;)<br>
+=C2=A0 =C2=A0 if (href) {<br>
+=C2=A0 =C2=A0 =C2=A0 href =3D href.replace(/.*(?=3D#[^\s]+$)/, &#39;&#39;)=
 // strip for ie7<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 var target=C2=A0 =3D $this.attr(&#39;data-target&#39;) || hr=
ef<br>
+=C2=A0 =C2=A0 var $target =3D $(document).find(target)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!$target.hasClass(&#39;carousel&#39;)) return<br>
+<br>
=C2=A0 =C2=A0 =C2=A0var options =3D $.extend({}, $target.data(), $this.data=
())<br>
=C2=A0 =C2=A0 =C2=A0var slideIndex =3D $this.attr(&#39;data-slide-to&#39;)<=
br>
=C2=A0 =C2=A0 =C2=A0if (slideIndex) options.interval =3D false<br>
@@ -531,13 +546,14 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: collapse.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#collapse" rel=3D"norefer=
rer" target=3D"_blank">http://getbootstrap.com/javascript/#collapse</a><br>
+ * Bootstrap: collapse.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#collapse" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#collapse</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
+/* jshint latedef: false */<br>
<br>
=C2=A0+function ($) {<br>
=C2=A0 =C2=A0&#39;use strict&#39;;<br>
@@ -561,7 +577,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0if (this.options.toggle) this.toggle()<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Collapse.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Collapse.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Collapse.TRANSITION_DURATION =3D 350<br>
<br>
@@ -668,7 +684,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Collapse.prototype.getParent =3D function () {<br>
-=C2=A0 =C2=A0 return $(this.options.parent)<br>
+=C2=A0 =C2=A0 return $(document).find(this.options.parent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.find(&#39;[data-toggle=3D&quot;collapse&quot;][=
data-parent=3D&quot;&#39; + this.options.parent + &#39;&quot;]&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.each($.proxy(function (i, element) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var $element =3D $(element)<br>
@@ -691,7 +707,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0var target =3D $trigger.attr(&#39;data-target&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|| (href =3D $trigger.attr(&#39;href&#39;)) &amp=
;&amp; href.replace(/.*(?=3D#[^\s]+$)/, &#39;&#39;) // strip for ie7<br>
<br>
-=C2=A0 =C2=A0 return $(target)<br>
+=C2=A0 =C2=A0 return $(document).find(target)<br>
=C2=A0 =C2=A0}<br>
<br>
<br>
@@ -743,10 +759,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: dropdown.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#dropdowns" rel=3D"norefe=
rrer" target=3D"_blank">http://getbootstrap.com/javascript/#dropdowns</a><b=
r>
+ * Bootstrap: dropdown.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#dropdowns" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#dropdowns</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -763,7 +779,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0$(element).on(&#39;<a href=3D"http://click.bs" target=
=3D"_blank">click.bs</a>.dropdown&#39;, this.toggle)<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Dropdown.VERSION =3D &#39;3.3.6&#39;<br>
+=C2=A0 Dropdown.VERSION =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0function getParent($this) {<br>
=C2=A0 =C2=A0 =C2=A0var selector =3D $this.attr(&#39;data-target&#39;)<br>
@@ -773,7 +789,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D selector &amp;&amp; /#[A-Za-z]/.tes=
t(selector) &amp;&amp; selector.replace(/.*(?=3D#[^\s]*$)/, &#39;&#39;) // =
strip for ie7<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 var $parent =3D selector &amp;&amp; $(selector)<br>
+=C2=A0 =C2=A0 var $parent =3D selector !=3D=3D &#39;#&#39; ? $(document).f=
ind(selector) : null<br>
<br>
=C2=A0 =C2=A0 =C2=A0return $parent &amp;&amp; $parent.length ? $parent : $t=
his.parent()<br>
=C2=A0 =C2=A0}<br>
@@ -909,10 +925,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: modal.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#modals" rel=3D"noreferre=
r" target=3D"_blank">http://getbootstrap.com/javascript/#modals</a><br>
+ * Bootstrap: modal.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#modals" rel=3D=
"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascript=
/#modals</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -924,15 +940,16 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
<br>
=C2=A0 =C2=A0var Modal =3D function (element, options) {<br>
-=C2=A0 =C2=A0 this.options=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D options<br>
-=C2=A0 =C2=A0 this.$body=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D $(document.body)<br>
-=C2=A0 =C2=A0 this.$element=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D $=
(element)<br>
-=C2=A0 =C2=A0 this.$dialog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D this.$element.find(&#39;.modal-dialog&#39;)<br>
-=C2=A0 =C2=A0 this.$backdrop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D n=
ull<br>
-=C2=A0 =C2=A0 this.isShown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D null<br>
-=C2=A0 =C2=A0 this.originalBodyPad=C2=A0 =C2=A0 =C2=A0=3D null<br>
-=C2=A0 =C2=A0 this.scrollbarWidth=C2=A0 =C2=A0 =C2=A0 =3D 0<br>
+=C2=A0 =C2=A0 this.options =3D options<br>
+=C2=A0 =C2=A0 this.$body =3D $(document.body)<br>
+=C2=A0 =C2=A0 this.$element =3D $(element)<br>
+=C2=A0 =C2=A0 this.$dialog =3D this.$element.find(&#39;.modal-dialog&#39;)=
<br>
+=C2=A0 =C2=A0 this.$backdrop =3D null<br>
+=C2=A0 =C2=A0 this.isShown =3D null<br>
+=C2=A0 =C2=A0 this.originalBodyPad =3D null<br>
+=C2=A0 =C2=A0 this.scrollbarWidth =3D 0<br>
=C2=A0 =C2=A0 =C2=A0this.ignoreBackdropClick =3D false<br>
+=C2=A0 =C2=A0 this.fixedContent =3D &#39;.navbar-fixed-top, .navbar-fixed-=
bottom&#39;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (this.options.remote) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0this.$element<br>
@@ -943,7 +960,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Modal.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Modal.VERSION =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Modal.TRANSITION_DURATION =3D 300<br>
=C2=A0 =C2=A0Modal.BACKDROP_TRANSITION_DURATION =3D 150<br>
@@ -960,7 +977,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br>
<br>
=C2=A0 =C2=A0Modal.prototype.show =3D function (_relatedTarget) {<br>
=C2=A0 =C2=A0 =C2=A0var that =3D this<br>
-=C2=A0 =C2=A0 var e=C2=A0 =C2=A0 =3D $.Event(&#39;show.bs.modal&#39;, { re=
latedTarget: _relatedTarget })<br>
+=C2=A0 =C2=A0 var e =3D $.Event(&#39;show.bs.modal&#39;, { relatedTarget: =
_relatedTarget })<br>
<br>
=C2=A0 =C2=A0 =C2=A0this.$element.trigger(e)<br>
<br>
@@ -1050,7 +1067,9 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0$(document)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.off(&#39;focusin.bs.modal&#39;) // guard agains=
t infinite focus loop<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.on(&#39;focusin.bs.modal&#39;, $.proxy(function=
 (e) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (this.$element[0] !=3D=3D e.target &amp;&am=
p; !this.$element.has(e.target).length) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (document !=3D=3D e.target &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 this.$element[0] !=3D=3D e.target &amp;=
&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !this.$element.has(e.target).length) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this.$element.trigger(&#39;focus&#=
39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}, this))<br>
@@ -1152,7 +1171,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0var modalIsOverflowing =3D this.$element[0].scrollHeigh=
t &gt; document.documentElement.clientHeight<br>
<br>
=C2=A0 =C2=A0 =C2=A0this.$element.css({<br>
-=C2=A0 =C2=A0 =C2=A0 paddingLeft:=C2=A0 !this.bodyIsOverflowing &amp;&amp;=
 modalIsOverflowing ? this.scrollbarWidth : &#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 paddingLeft: !this.bodyIsOverflowing &amp;&amp; modal=
IsOverflowing ? this.scrollbarWidth : &#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0paddingRight: this.bodyIsOverflowing &amp;&amp; =
!modalIsOverflowing ? this.scrollbarWidth : &#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0})<br>
=C2=A0 =C2=A0}<br>
@@ -1177,11 +1196,26 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0 =C2=A0Modal.prototype.setScrollbar =3D function () {<br>
=C2=A0 =C2=A0 =C2=A0var bodyPad =3D parseInt((this.$body.css(&#39;padding-r=
ight&#39;) || 0), 10)<br>
=C2=A0 =C2=A0 =C2=A0this.originalBodyPad =3D document.body.style.paddingRig=
ht || &#39;&#39;<br>
-=C2=A0 =C2=A0 if (this.bodyIsOverflowing) this.$body.css(&#39;padding-righ=
t&#39;, bodyPad + this.scrollbarWidth)<br>
+=C2=A0 =C2=A0 var scrollbarWidth =3D this.scrollbarWidth<br>
+=C2=A0 =C2=A0 if (this.bodyIsOverflowing) {<br>
+=C2=A0 =C2=A0 =C2=A0 this.$body.css(&#39;padding-right&#39;, bodyPad + scr=
ollbarWidth)<br>
+=C2=A0 =C2=A0 =C2=A0 $(this.fixedContent).each(function (index, element) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var actualPadding =3D element.style.paddingRig=
ht<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var calculatedPadding =3D $(element).css(&#39;=
padding-right&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(element)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data(&#39;padding-right&#39;, actualPa=
dding)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .css(&#39;padding-right&#39;, parseFloa=
t(calculatedPadding) + scrollbarWidth + &#39;px&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 })<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Modal.prototype.resetScrollbar =3D function () {<br>
=C2=A0 =C2=A0 =C2=A0this.$body.css(&#39;padding-right&#39;, this.originalBo=
dyPad)<br>
+=C2=A0 =C2=A0 $(this.fixedContent).each(function (index, element) {<br>
+=C2=A0 =C2=A0 =C2=A0 var padding =3D $(element).data(&#39;padding-right&#3=
9;)<br>
+=C2=A0 =C2=A0 =C2=A0 $(element).removeData(&#39;padding-right&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 element.style.paddingRight =3D padding ? padding : &#=
39;&#39;<br>
+=C2=A0 =C2=A0 })<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Modal.prototype.measureScrollbar =3D function () { // thx wals=
h<br>
@@ -1199,8 +1233,8 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0function Plugin(option, _relatedTarget) {<br>
=C2=A0 =C2=A0 =C2=A0return this.each(function () {<br>
-=C2=A0 =C2=A0 =C2=A0 var $this=C2=A0 =C2=A0=3D $(this)<br>
-=C2=A0 =C2=A0 =C2=A0 var data=C2=A0 =C2=A0 =3D $this.data(&#39;bs.modal&#3=
9;)<br>
+=C2=A0 =C2=A0 =C2=A0 var $this =3D $(this)<br>
+=C2=A0 =C2=A0 =C2=A0 var data =3D $this.data(&#39;bs.modal&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0var options =3D $.extend({}, Modal.DEFAULTS, $th=
is.data(), typeof option =3D=3D &#39;object&#39; &amp;&amp; option)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data) $this.data(&#39;bs.modal&#39;, (data =
=3D new Modal(this, options)))<br>
@@ -1211,7 +1245,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0var old =3D $.fn.modal<br>
<br>
-=C2=A0 $.fn.modal=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D Plugi=
n<br>
+=C2=A0 $.fn.modal =3D Plugin<br>
=C2=A0 =C2=A0$.fn.modal.Constructor =3D Modal<br>
<br>
<br>
@@ -1228,10 +1262,13 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 =C2=A0$(document).on(&#39;<a href=3D"http://click.bs" target=3D"_bla=
nk">click.bs</a>.modal.data-api&#39;, &#39;[data-toggle=3D&quot;modal&quot;=
]&#39;, function (e) {<br>
-=C2=A0 =C2=A0 var $this=C2=A0 =C2=A0=3D $(this)<br>
-=C2=A0 =C2=A0 var href=C2=A0 =C2=A0 =3D $this.attr(&#39;href&#39;)<br>
-=C2=A0 =C2=A0 var $target =3D $($this.attr(&#39;data-target&#39;) || (href=
 &amp;&amp; href.replace(/.*(?=3D#[^\s]+$)/, &#39;&#39;))) // strip for ie7=
<br>
-=C2=A0 =C2=A0 var option=C2=A0 =3D $target.data(&#39;bs.modal&#39;) ? &#39=
;toggle&#39; : $.extend({ remote: !/#/.test(href) &amp;&amp; href }, $targe=
t.data(), $this.data())<br>
+=C2=A0 =C2=A0 var $this =3D $(this)<br>
+=C2=A0 =C2=A0 var href =3D $this.attr(&#39;href&#39;)<br>
+=C2=A0 =C2=A0 var target =3D $this.attr(&#39;data-target&#39;) ||<br>
+=C2=A0 =C2=A0 =C2=A0 (href &amp;&amp; href.replace(/.*(?=3D#[^\s]+$)/, &#3=
9;&#39;)) // strip for ie7<br>
+<br>
+=C2=A0 =C2=A0 var $target =3D $(document).find(target)<br>
+=C2=A0 =C2=A0 var option =3D $target.data(&#39;bs.modal&#39;) ? &#39;toggl=
e&#39; : $.extend({ remote: !/#/.test(href) &amp;&amp; href }, $target.data=
(), $this.data())<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ($<a href=3D"http://this.is" rel=3D"noreferrer" targ=
et=3D"_blank">this.is</a>(&#39;a&#39;)) e.preventDefault()<br>
<br>
@@ -1247,18 +1284,148 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {=
<br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: tooltip.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#tooltip" rel=3D"noreferr=
er" target=3D"_blank">http://getbootstrap.com/javascript/#tooltip</a><br>
+ * Bootstrap: tooltip.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#tooltip" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#tooltip</a><br>
=C2=A0 * Inspired by the original jQuery.tipsy by Jason Frame<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
-<br>
=C2=A0+function ($) {<br>
=C2=A0 =C2=A0&#39;use strict&#39;;<br>
<br>
+=C2=A0 var DISALLOWED_ATTRIBUTES =3D [&#39;sanitize&#39;, &#39;whiteList&#=
39;, &#39;sanitizeFn&#39;]<br>
+<br>
+=C2=A0 var uriAttrs =3D [<br>
+=C2=A0 =C2=A0 &#39;background&#39;,<br>
+=C2=A0 =C2=A0 &#39;cite&#39;,<br>
+=C2=A0 =C2=A0 &#39;href&#39;,<br>
+=C2=A0 =C2=A0 &#39;itemtype&#39;,<br>
+=C2=A0 =C2=A0 &#39;longdesc&#39;,<br>
+=C2=A0 =C2=A0 &#39;poster&#39;,<br>
+=C2=A0 =C2=A0 &#39;src&#39;,<br>
+=C2=A0 =C2=A0 &#39;xlink:href&#39;<br>
+=C2=A0 ]<br>
+<br>
+=C2=A0 var ARIA_ATTRIBUTE_PATTERN =3D /^aria-[\w-]*$/i<br>
+<br>
+=C2=A0 var DefaultWhitelist =3D {<br>
+=C2=A0 =C2=A0 // Global attributes allowed on any supplied element below.<=
br>
+=C2=A0 =C2=A0 &#39;*&#39;: [&#39;class&#39;, &#39;dir&#39;, &#39;id&#39;, =
&#39;lang&#39;, &#39;role&#39;, ARIA_ATTRIBUTE_PATTERN],<br>
+=C2=A0 =C2=A0 a: [&#39;target&#39;, &#39;href&#39;, &#39;title&#39;, &#39;=
rel&#39;],<br>
+=C2=A0 =C2=A0 area: [],<br>
+=C2=A0 =C2=A0 b: [],<br>
+=C2=A0 =C2=A0 br: [],<br>
+=C2=A0 =C2=A0 col: [],<br>
+=C2=A0 =C2=A0 code: [],<br>
+=C2=A0 =C2=A0 div: [],<br>
+=C2=A0 =C2=A0 em: [],<br>
+=C2=A0 =C2=A0 hr: [],<br>
+=C2=A0 =C2=A0 h1: [],<br>
+=C2=A0 =C2=A0 h2: [],<br>
+=C2=A0 =C2=A0 h3: [],<br>
+=C2=A0 =C2=A0 h4: [],<br>
+=C2=A0 =C2=A0 h5: [],<br>
+=C2=A0 =C2=A0 h6: [],<br>
+=C2=A0 =C2=A0 i: [],<br>
+=C2=A0 =C2=A0 img: [&#39;src&#39;, &#39;alt&#39;, &#39;title&#39;, &#39;wi=
dth&#39;, &#39;height&#39;],<br>
+=C2=A0 =C2=A0 li: [],<br>
+=C2=A0 =C2=A0 ol: [],<br>
+=C2=A0 =C2=A0 p: [],<br>
+=C2=A0 =C2=A0 pre: [],<br>
+=C2=A0 =C2=A0 s: [],<br>
+=C2=A0 =C2=A0 small: [],<br>
+=C2=A0 =C2=A0 span: [],<br>
+=C2=A0 =C2=A0 sub: [],<br>
+=C2=A0 =C2=A0 sup: [],<br>
+=C2=A0 =C2=A0 strong: [],<br>
+=C2=A0 =C2=A0 u: [],<br>
+=C2=A0 =C2=A0 ul: []<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 /**<br>
+=C2=A0 =C2=A0* A pattern that recognizes a commonly useful subset of URLs =
that are safe.<br>
+=C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0* Shoutout to Angular 7 <a href=3D"https://github.com/angular=
/angular/blob/7.2.4/packages/core/src/sanitization/url_sanitizer.ts" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/angular/angular/blob/7.2.=
4/packages/core/src/sanitization/url_sanitizer.ts</a><br>
+=C2=A0 =C2=A0*/<br>
+=C2=A0 var SAFE_URL_PATTERN =3D /^(?:(?:https?|mailto|ftp|tel|file):|[^&am=
p;:/?#]*(?:[/?#]|$))/gi<br>
+<br>
+=C2=A0 /**<br>
+=C2=A0 =C2=A0* A pattern that matches safe data URLs. Only matches image, =
video and audio types.<br>
+=C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0* Shoutout to Angular 7 <a href=3D"https://github.com/angular=
/angular/blob/7.2.4/packages/core/src/sanitization/url_sanitizer.ts" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/angular/angular/blob/7.2.=
4/packages/core/src/sanitization/url_sanitizer.ts</a><br>
+=C2=A0 =C2=A0*/<br>
+=C2=A0 var DATA_URL_PATTERN =3D /^data:(?:image\/(?:bmp|gif|jpeg|jpg|png|t=
iff|webp)|video\/(?:mpeg|mp4|ogg|webm)|audio\/(?:mp3|oga|ogg|opus));base64,=
[a-z0-9+/]+=3D*$/i<br>
+<br>
+=C2=A0 function allowedAttribute(attr, allowedAttributeList) {<br>
+=C2=A0 =C2=A0 var attrName =3D attr.nodeName.toLowerCase()<br>
+<br>
+=C2=A0 =C2=A0 if ($.inArray(attrName, allowedAttributeList) !=3D=3D -1) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 if ($.inArray(attrName, uriAttrs) !=3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return Boolean(attr.nodeValue.match(SAFE_URL_P=
ATTERN) || attr.nodeValue.match(DATA_URL_PATTERN))<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 return true<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 var regExp =3D $(allowedAttributeList).filter(function (inde=
x, value) {<br>
+=C2=A0 =C2=A0 =C2=A0 return value instanceof RegExp<br>
+=C2=A0 =C2=A0 })<br>
+<br>
+=C2=A0 =C2=A0 // Check if a regular expression validates the attribute.<br=
>
+=C2=A0 =C2=A0 for (var i =3D 0, l =3D regExp.length; i &lt; l; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 if (attrName.match(regExp[i])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 function sanitizeHtml(unsafeHtml, whiteList, sanitizeFn) {<br>
+=C2=A0 =C2=A0 if (unsafeHtml.length =3D=3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 return unsafeHtml<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (sanitizeFn &amp;&amp; typeof sanitizeFn =3D=3D=3D &#39;f=
unction&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 return sanitizeFn(unsafeHtml)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // IE 8 and below don&#39;t support createHTMLDocument<br>
+=C2=A0 =C2=A0 if (!document.implementation || !document.implementation.cre=
ateHTMLDocument) {<br>
+=C2=A0 =C2=A0 =C2=A0 return unsafeHtml<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 var createdDocument =3D document.implementation.createHTMLDo=
cument(&#39;sanitization&#39;)<br>
+=C2=A0 =C2=A0 createdDocument.body.innerHTML =3D unsafeHtml<br>
+<br>
+=C2=A0 =C2=A0 var whitelistKeys =3D $.map(whiteList, function (el, i) { re=
turn i })<br>
+=C2=A0 =C2=A0 var elements =3D $(createdDocument.body).find(&#39;*&#39;)<b=
r>
+<br>
+=C2=A0 =C2=A0 for (var i =3D 0, len =3D elements.length; i &lt; len; i++) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 var el =3D elements[i]<br>
+=C2=A0 =C2=A0 =C2=A0 var elName =3D el.nodeName.toLowerCase()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 if ($.inArray(elName, whitelistKeys) =3D=3D=3D -1) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 el.parentNode.removeChild(el)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 var attributeList =3D $.map(el.attributes, function (=
el) { return el })<br>
+=C2=A0 =C2=A0 =C2=A0 var whitelistedAttributes =3D [].concat(whiteList[&#3=
9;*&#39;] || [], whiteList[elName] || [])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 for (var j =3D 0, len2 =3D attributeList.length; j &l=
t; len2; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!allowedAttribute(attributeList[j], whitel=
istedAttributes)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 el.removeAttribute(attributeList[j].nod=
eName)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return createdDocument.body.innerHTML<br>
+=C2=A0 }<br>
+<br>
=C2=A0 =C2=A0// TOOLTIP PUBLIC CLASS DEFINITION<br>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
@@ -1274,7 +1441,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0this.init(&#39;tooltip&#39;, element, options)<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Tooltip.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Tooltip.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Tooltip.TRANSITION_DURATION =3D 150<br>
<br>
@@ -1291,7 +1458,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0 =C2=A0viewport: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0selector: &#39;body&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0padding: 0<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 sanitize : true,<br>
+=C2=A0 =C2=A0 sanitizeFn : null,<br>
+=C2=A0 =C2=A0 whiteList : DefaultWhitelist<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Tooltip.prototype.init =3D function (type, element, options) {=
<br>
@@ -1299,7 +1469,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0this.type=C2=A0 =C2=A0 =C2=A0 =3D type<br>
=C2=A0 =C2=A0 =C2=A0this.$element=C2=A0 =3D $(element)<br>
=C2=A0 =C2=A0 =C2=A0this.options=C2=A0 =C2=A0=3D this.getOptions(options)<b=
r>
-=C2=A0 =C2=A0 this.$viewport =3D this.options.viewport &amp;&amp; $($.isFu=
nction(this.options.viewport) ? this.options.viewport.call(this, this.$elem=
ent) : (this.options.viewport.selector || this.options.viewport))<br>
+=C2=A0 =C2=A0 this.$viewport =3D this.options.viewport &amp;&amp; $(docume=
nt).find($.isFunction(this.options.viewport) ? this.options.viewport.call(t=
his, this.$element) : (this.options.viewport.selector || this.options.viewp=
ort))<br>
=C2=A0 =C2=A0 =C2=A0this.inState=C2=A0 =C2=A0=3D { click: false, hover: fal=
se, focus: false }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (this.$element[0] instanceof document.constructor &a=
mp;&amp; !this.options.selector) {<br>
@@ -1332,7 +1502,15 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Tooltip.prototype.getOptions =3D function (options) {<br>
-=C2=A0 =C2=A0 options =3D $.extend({}, this.getDefaults(), this.$element.d=
ata(), options)<br>
+=C2=A0 =C2=A0 var dataAttributes =3D this.$element.data()<br>
+<br>
+=C2=A0 =C2=A0 for (var dataAttr in dataAttributes) {<br>
+=C2=A0 =C2=A0 =C2=A0 if (dataAttributes.hasOwnProperty(dataAttr) &amp;&amp=
; $.inArray(dataAttr, DISALLOWED_ATTRIBUTES) !=3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 delete dataAttributes[dataAttr]<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 options =3D $.extend({}, this.getDefaults(), dataAttributes,=
 options)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (options.delay &amp;&amp; typeof options.delay =3D=
=3D &#39;number&#39;) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0options.delay =3D {<br>
@@ -1341,6 +1519,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (options.sanitize) {<br>
+=C2=A0 =C2=A0 =C2=A0 options.template =3D sanitizeHtml(options.template, o=
ptions.whiteList, options.sanitizeFn)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return options<br>
=C2=A0 =C2=A0}<br>
<br>
@@ -1452,7 +1634,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.addClass(placement)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data(&#39;bs.&#39; + this.type, this)<br=
>
<br>
-=C2=A0 =C2=A0 =C2=A0 this.options.container ? $tip.appendTo(this.options.c=
ontainer) : $tip.insertAfter(this.$element)<br>
+=C2=A0 =C2=A0 =C2=A0 this.options.container ? $tip.appendTo($(document).fi=
nd(this.options.container)) : $tip.insertAfter(this.$element)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0this.$element.trigger(&#39;<a href=3D"http://ins=
erted.bs" rel=3D"noreferrer" target=3D"_blank">inserted.bs</a>.&#39; + this=
.type)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0var pos=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D th=
is.getPosition()<br>
@@ -1554,7 +1736,16 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0 =C2=A0var $tip=C2=A0 =3D this.tip()<br>
=C2=A0 =C2=A0 =C2=A0var title =3D this.getTitle()<br>
<br>
-=C2=A0 =C2=A0 $tip.find(&#39;.tooltip-inner&#39;)[this.options.html ? &#39=
;html&#39; : &#39;text&#39;](title)<br>
+=C2=A0 =C2=A0 if (this.options.html) {<br>
+=C2=A0 =C2=A0 =C2=A0 if (this.options.sanitize) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D sanitizeHtml(title, this.options.whi=
teList, this.options.sanitizeFn)<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.tooltip-inner&#39;).html(title)<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.tooltip-inner&#39;).text(title)<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0$tip.removeClass(&#39;fade in top bottom left right&#39=
;)<br>
=C2=A0 =C2=A0}<br>
<br>
@@ -1565,9 +1756,11 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0function complete() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (that.hoverState !=3D &#39;in&#39;) $tip.deta=
ch()<br>
-=C2=A0 =C2=A0 =C2=A0 that.$element<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .removeAttr(&#39;aria-describedby&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .trigger(&#39;<a href=3D"http://hidden.bs" rel=
=3D"noreferrer" target=3D"_blank">hidden.bs</a>.&#39; + that.type)<br>
+=C2=A0 =C2=A0 =C2=A0 if (that.$element) { // TODO: Check whether guarding =
this code with this `if` is really necessary.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 that.$element<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .removeAttr(&#39;aria-describedby&#39;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .trigger(&#39;<a href=3D"http://hidden.=
bs" rel=3D"noreferrer" target=3D"_blank">hidden.bs</a>.&#39; + that.type)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0callback &amp;&amp; callback()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1610,7 +1803,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0// width and height are missing in IE8, so compu=
te them manually; see <a href=3D"https://github.com/twbs/bootstrap/issues/1=
4093" rel=3D"noreferrer" target=3D"_blank">https://github.com/twbs/bootstra=
p/issues/14093</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0elRect =3D $.extend({}, elRect, { width: elRect.=
right - elRect.left, height: elRect.bottom - elRect.top })<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 var elOffset=C2=A0 =3D isBody ? { top: 0, left: 0 } : $eleme=
nt.offset()<br>
+=C2=A0 =C2=A0 var isSvg =3D window.SVGElement &amp;&amp; el instanceof win=
dow.SVGElement<br>
+=C2=A0 =C2=A0 // Avoid using $.offset() on SVGs since it gives incorrect r=
esults in jQuery 3.<br>
+=C2=A0 =C2=A0 // See <a href=3D"https://github.com/twbs/bootstrap/issues/2=
0280" rel=3D"noreferrer" target=3D"_blank">https://github.com/twbs/bootstra=
p/issues/20280</a><br>
+=C2=A0 =C2=A0 var elOffset=C2=A0 =3D isBody ? { top: 0, left: 0 } : (isSvg=
 ? null : $element.offset())<br>
=C2=A0 =C2=A0 =C2=A0var scroll=C2=A0 =C2=A0 =3D { scroll: isBody ? document=
.documentElement.scrollTop || document.body.scrollTop : $element.scrollTop(=
) }<br>
=C2=A0 =C2=A0 =C2=A0var outerDims =3D isBody ? { width: $(window).width(), =
height: $(window).height() } : null<br>
<br>
@@ -1726,9 +1922,13 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0that.$tip =3D null<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0that.$arrow =3D null<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0that.$viewport =3D null<br>
+=C2=A0 =C2=A0 =C2=A0 that.$element =3D null<br>
=C2=A0 =C2=A0 =C2=A0})<br>
=C2=A0 =C2=A0}<br>
<br>
+=C2=A0 Tooltip.prototype.sanitizeHtml =3D function (unsafeHtml) {<br>
+=C2=A0 =C2=A0 return sanitizeHtml(unsafeHtml, this.options.whiteList, this=
.options.sanitizeFn)<br>
+=C2=A0 }<br>
<br>
=C2=A0 =C2=A0// TOOLTIP PLUGIN DEFINITION<br>
=C2=A0 =C2=A0// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
@@ -1762,10 +1962,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: popover.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#popovers" rel=3D"norefer=
rer" target=3D"_blank">http://getbootstrap.com/javascript/#popovers</a><br>
+ * Bootstrap: popover.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#popovers" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#popovers</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -1782,7 +1982,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0if (!$.fn.tooltip) throw new Error(&#39;Popover requires toolt=
ip.js&#39;)<br>
<br>
-=C2=A0 Popover.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Popover.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Popover.DEFAULTS =3D $.extend({}, $.fn.tooltip.Constructor.DEF=
AULTS, {<br>
=C2=A0 =C2=A0 =C2=A0placement: &#39;right&#39;,<br>
@@ -1808,10 +2008,25 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0 =C2=A0 =C2=A0var title=C2=A0 =C2=A0=3D this.getTitle()<br>
=C2=A0 =C2=A0 =C2=A0var content =3D this.getContent()<br>
<br>
-=C2=A0 =C2=A0 $tip.find(&#39;.popover-title&#39;)[this.options.html ? &#39=
;html&#39; : &#39;text&#39;](title)<br>
-=C2=A0 =C2=A0 $tip.find(&#39;.popover-content&#39;).children().detach().en=
d()[ // we use append for html objects to maintain js events<br>
-=C2=A0 =C2=A0 =C2=A0 this.options.html ? (typeof content =3D=3D &#39;strin=
g&#39; ? &#39;html&#39; : &#39;append&#39;) : &#39;text&#39;<br>
-=C2=A0 =C2=A0 ](content)<br>
+=C2=A0 =C2=A0 if (this.options.html) {<br>
+=C2=A0 =C2=A0 =C2=A0 var typeContent =3D typeof content<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 if (this.options.sanitize) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 title =3D this.sanitizeHtml(title)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (typeContent =3D=3D=3D &#39;string&#39;) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D this.sanitizeHtml(content)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.popover-title&#39;).html(title)<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.popover-content&#39;).children().deta=
ch().end()[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 typeContent =3D=3D=3D &#39;string&#39; ? &#39;=
html&#39; : &#39;append&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 ](content)<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.popover-title&#39;).text(title)<br>
+=C2=A0 =C2=A0 =C2=A0 $tip.find(&#39;.popover-content&#39;).children().deta=
ch().end().text(content)<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0$tip.removeClass(&#39;fade top bottom left right in&#39=
;)<br>
<br>
@@ -1830,8 +2045,8 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0return $e.attr(&#39;data-content&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|| (typeof o.content =3D=3D &#39;function&#39; ?=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o.content.call($e[0]) :<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 o.content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 o.content.call($e[0]) :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 o.content)<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0Popover.prototype.arrow =3D function () {<br>
@@ -1871,10 +2086,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: scrollspy.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#scrollspy" rel=3D"norefe=
rrer" target=3D"_blank">http://getbootstrap.com/javascript/#scrollspy</a><b=
r>
+ * Bootstrap: scrollspy.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#scrollspy" rel=
=3D"noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascr=
ipt/#scrollspy</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -1900,7 +2115,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0this.process()<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 ScrollSpy.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 ScrollSpy.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0ScrollSpy.DEFAULTS =3D {<br>
=C2=A0 =C2=A0 =C2=A0offset: 10<br>
@@ -2044,10 +2259,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: tab.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#tabs" rel=3D"noreferrer"=
 target=3D"_blank">http://getbootstrap.com/javascript/#tabs</a><br>
+ * Bootstrap: tab.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#tabs" rel=3D"n=
oreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascript/#=
tabs</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -2064,7 +2279,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0// jscs:enable requireDollarBeforejQueryAssignment<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Tab.VERSION =3D &#39;3.3.6&#39;<br>
+=C2=A0 Tab.VERSION =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Tab.TRANSITION_DURATION =3D 150<br>
<br>
@@ -2093,7 +2308,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0if (showEvent.isDefaultPrevented() || hideEvent.isDefau=
ltPrevented()) return<br>
<br>
-=C2=A0 =C2=A0 var $target =3D $(selector)<br>
+=C2=A0 =C2=A0 var $target =3D $(document).find(selector)<br>
<br>
=C2=A0 =C2=A0 =C2=A0this.activate($this.closest(&#39;li&#39;), $ul)<br>
=C2=A0 =C2=A0 =C2=A0this.activate($target, $target.parent(), function () {<=
br>
@@ -2118,15 +2333,15 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$active<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.removeClass(&#39;active&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.find(&#39;&gt; .dropdown-menu &gt; .acti=
ve&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .removeClass(&#39;active&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .removeClass(&#39;active&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.end()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.find(&#39;[data-toggle=3D&quot;tab&quot;=
]&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, false)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, false)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.addClass(&#39;active&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.find(&#39;[data-toggle=3D&quot;tab&quot;=
]&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, true)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, true)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (transition) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element[0].offsetWidth // reflow for tran=
sition<br>
@@ -2138,10 +2353,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (element.parent(&#39;.dropdown-menu&#39;).len=
gth) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.closest(&#39;li.dropdown&#39;)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addClass(&#39;active&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addClass(&#39;active&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.end()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.find(&#39;[data-toggle=3D&quot;ta=
b&quot;]&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, t=
rue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attr(&#39;aria-expanded&#39;, true)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0callback &amp;&amp; callback()<br>
@@ -2200,10 +2415,10 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<=
br>
=C2=A0}(jQuery);<br>
<br>
=C2=A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Bootstrap: affix.js v3.3.6<br>
- * <a href=3D"http://getbootstrap.com/javascript/#affix" rel=3D"noreferrer=
" target=3D"_blank">http://getbootstrap.com/javascript/#affix</a><br>
+ * Bootstrap: affix.js v3.4.1<br>
+ * <a href=3D"https://getbootstrap.com/docs/3.4/javascript/#affix" rel=3D"=
noreferrer" target=3D"_blank">https://getbootstrap.com/docs/3.4/javascript/=
#affix</a><br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
- * Copyright 2011-2015 Twitter, Inc.<br>
+ * Copyright 2011-2019 Twitter, Inc.<br>
=C2=A0 * Licensed under MIT (<a href=3D"https://github.com/twbs/bootstrap/b=
lob/master/LICENSE" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/twbs/bootstrap/blob/master/LICENSE</a>)<br>
=C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */<br>
<br>
@@ -2217,7 +2432,9 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0var Affix =3D function (element, options) {<br>
=C2=A0 =C2=A0 =C2=A0this.options =3D $.extend({}, Affix.DEFAULTS, options)<=
br>
<br>
-=C2=A0 =C2=A0 this.$target =3D $(this.options.target)<br>
+=C2=A0 =C2=A0 var target =3D this.options.target =3D=3D=3D Affix.DEFAULTS.=
target ? $(this.options.target) : $(document).find(this.options.target)<br>
+<br>
+=C2=A0 =C2=A0 this.$target =3D target<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.on(&#39;scroll.bs.affix.data-api&#39;, $.proxy(=
this.checkPosition, this))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.on(&#39;click.bs.affix.data-api&#39;,=C2=A0 $.p=
roxy(this.checkPositionWithEventLoop, this))<br>
<br>
@@ -2229,7 +2446,7 @@ if (typeof jQuery =3D=3D=3D &#39;undefined&#39;) {<br=
>
=C2=A0 =C2=A0 =C2=A0this.checkPosition()<br>
=C2=A0 =C2=A0}<br>
<br>
-=C2=A0 Affix.VERSION=C2=A0 =3D &#39;3.3.6&#39;<br>
+=C2=A0 Affix.VERSION=C2=A0 =3D &#39;3.4.1&#39;<br>
<br>
=C2=A0 =C2=A0Affix.RESET=C2=A0 =C2=A0 =3D &#39;affix affix-top affix-bottom=
&#39;<br>
<br>
diff --git a/lib/toaster/toastergui/static/js/bootstrap-3.4.1.min.js b/lib/=
toaster/toastergui/static/js/bootstrap-3.4.1.min.js<br>
new file mode 100644<br>
index 0000000000000000000000000000000000000000..eb0a8b410f59eb8abcd21e588f1=
a7b718db3eebd<br>
GIT binary patch<br>
literal 39680<br>
zcmdsg?R(qCwdeQyS5SzrLPjJd*=3Dc)23en@l&amp;aHRTI-9udv#Tn%5DAG$D1ap(JFcky<br=
>
z?fW}#^8$df)7|~DPx8nFFf*7rbKcLHgX7N*{%!Et;H#=3D?&gt;Smj525+BDKcAishO4I8<br>
z)U)H`o4mQQhtoxMdpx4{Uss#=3D+u~-`44$5xo=3D))Ri@}?BMbqTl@!(atm{Ox}i$z}6<br>
z`EqbqF7xf6S&gt;=3DO2ym~WO%Wbqc{&lt;q?Kn9$SfqRf{`nl|q@d38Pb&gt;3`hi+xMepwXN=
O_<br>
z%KY8n&lt;#t&lt;bhl!i!r}f~!WpA?|7TaRe47T~-?}}|+YrkYPKe)at7fn%&gt;!)A1!+|~I2=
<br>
zt1A{wGJl(G2YD(lm|mCDpZ-p-n%0|j(F~J8GP*dqw5usb!VGiVI(vF}m|vV;o_(&gt;~<br>
zou(&lt;&gt;Iz0S&gt;ew^Y*e)073&gt;~yz#c192W)p-xz=3DGz)`9-L0Uz!p^7!3rQIh+f?_=
gLU&lt;e<br>
zftZ!9-RH^ZVK^GQwU({5mbAe9_HLau`I~K4)&amp;+s&amp;Ww}gU7l20~a&amp;S5&gt;(q&g=
t;iEbHEJ$<br>
zjHXqY50k4p&gt;X`VKjqdaG;N)R6-{#HTwj9)X^QO4XtGj0CMn{|7t{fJlDWHFIlW&amp;LR<b=
r>
zw7%PHs%?WiHlb-=3DE=3DLdJW;CW3Ka9(8fW8iH`h#jH^Ka5+wYa;@%VxUR=3D2-5_bxv1U<br=
>
zfFW-(8t3W#U-GM;i^i{Mmb`1-0eF(}AF6+ZZTws@)nxoSd{+4jbRAT!w*GRK_}?_l<br>
z!~7aJP0%j}MLEbvK(%ICH}BW^MR9qMrj9U10^)o0n$fcdh55lLZGRtx4i5q8{4K$w<br>
z-sFoSTTfd%nciO&amp;&lt;?;&gt;aZPqsc?a6qVuk#ziokv@(vU0i3XKvGhQdkMFXxe03u#eH=
S<br>
zs0F2T9fM{neO_Pvq`$V)Y_nOv=3DVoK{;;pPl4-X^!H&amp;k}uaj$M6x}fl&lt;7t5^4Cd;C}=
<br>
zE$TW=3DvUR&gt;~lFLuWnL`+22bc^Y_b^$26aAcwb4I)AVqMkw=3DwY5s|NQd%A6~uwW1284<b=
r>
zOvc&amp;t&amp;G*m$_`|C=3DxcOf%{`CEG`jMXg&lt;^)eR+p4LEYf1m;MKUX0JE$w4W=3D#V=
w#&lt;LXI<br>
z5QEw6hDD11?eS`xUnir{;bAe|=3D9_i4$cM+%&amp;xYseCl^2dwZ8o9$&gt;?~TpaDiqJ^{~6=
<br>
zi}Q=3DiS;3sGO6#Ff!e|Pvx&amp;-mfZEFT4$fcSt^CnxYhMp(^39Nky6qyRlMtJjW^)?@l<br=
>
z9-70$2CHOTdXZmeck2c?S54P&gt;dDE;g_X-o|{xzu0`cn%d`6jKWF9{V1;&amp;@N+8c;lt<b=
r>
zLx=3DrNUXm||BN|qx@bx;Y&gt;tRxqpx?TOc^n&gt;Az@b{3U1!TY8J$;qm{&amp;RKWrxGw9U=
jd9<br>
zE+7PLBdr0vl%X^CKizhN5f!6*&lt;%Gn=3Dra6Jw0PnbzAw!-vQ$hn`um-a^cxC4&lt;coxaO<=
br>
zObKY5kQ^&amp;-yr?Wl`V^PbMYdi8u|X~XlTCH{bycFn-J+?sX%;&gt;xD?GXe0W@w6n540C<b=
r>
zH$d7bPY%(_(T&gt;|mUdtrg6huuOqWD+}F8x%RaXz|dI6eUnB2Es(Rsk`sHYCPsY)Sr0<br>
z13opphs&gt;D1c=3D^rqKYjb=3D2lNzzF6wWqYzbhc;FF#Piecpz`fGOza=3D57o6G3{_)lWGT=
<br>
z3a7JFz{J)TYIEH~k*nhZl$$iw&amp;CNPT=3DjuG4%EfRr!w~rta`cA=3DOc&amp;F{W|kdp&l=
t;X4*B<br>
zuVsO60Ebzk7t`r9A$WMsWFrRPHL0I~S!P#j=3Dw2%Qrv~qFl@`RfL3x|I1~iqt&amp;DO~*<br=
>
zSv9xoWL)AQ&lt;L_wR9Hj|O05|W}&gt;ohGvxTFi&lt;7O^nFa(4^wxu`BdSK~lmsA;mlybsBR=
<br>
zTj_uo&amp;E+}olx{q(XC?jsjsXB@C(fBnFm1Q&lt;C*xw8EtkR`@{w@h95_O++zj*a!O3Ve<b=
r>
z&lt;I!C&amp;2+#Ni5D3EvOLQa2&lt;#Xcb!Dy%87&gt;s_S@d&lt;u~+aTNQH^DTQgA*VKztC=
Xs_^C=3DX<br>
z?U@KZ)evc-mnsvMfkb&lt;A`zOrbc5j|+K?)UMRLH^;l3Cc*p&lt;ORl`Qm5b0p!lG!GfVJ<br=
>
z=3D@8Qln)F*Vjv$cOT_H9%bq8$MU^Gj3@T=3D;V&amp;inDQ&amp;IF+O#L)2U-QMZu7&amp;j=
C+sVK0v<br>
zAXZ(nEwMG@?(kqBgt{icF#W8&amp;0RSHIH7tqvog&amp;h+ZIMkNC2NS$WPA`e&gt;3spo2nV=
#@<br>
ziAR!0wq8V!{7wtu=3DW-Qs`Z9X*VOFmLevsGet5|&lt;wW*_0_kEtRksa#I-IRgXy+bM)z<br>
zU$|&lt;(PUnS)uiP&lt;4u!o&gt;I*wClUhAs$eQ^n=3DWG1O-8CcWu!4AcSrp+{-SJwF@EQa}=
J;<br>
zziOH!*DxXKWHd9x=3Dh0_xi@E@Z)E;&amp;TYPc@8P&lt;a9^O8bLtvwF#wBqCd28(gjLwmtWg=
<br>
z@yCHPgiH&amp;NDoRWl;`NM=3Df8?1Ai*j`S&lt;apZTm^HQnkOZ&amp;llg*nR?Rw$)R*!7nI=
NAIJ<br>
zDrd3Cpl{SIDrRLg!A5T@*yHPoZwPtH1Y&gt;et74l7ncFUB6fIP3)1&amp;eckrzqiYfLsb1<b=
r>
zJrTMO?-WgbTL(AvJ=3D34__g7W6T|&amp;c+sFCy=3DJX=3D=3DpO4=3DryaWdYhoZ{x%f~Q6z=
eFc4a<br>
zOG1dovRCjL4i688NmVx0-C|Wk?{C1B2d1S@?T1&gt;d;J@A3+!Dy31m%o3dnUy1(&amp;;b)<b=
r>
za&lt;6rsy=3D9eqPp`%M1(2IwNxH6)?Eseg$7o5|c&lt;M&lt;4%&lt;Hr6O{6Dn0wrzXl{9S*=
xV81D<br>
z^6;&gt;P`H*%r-SWJg6;ncjyrpNk7pkVU;8}^LRo&gt;lR$-V&amp;L;aVzL;lk=3D&gt;P`y|=
c!Jvjm<br>
zq&lt;=3D9OLDmcy7(k&lt;kMMno)^jd_!JvkZsC8qZ_&gt;g+f9voQ|~^@*`${0^?R83ezfAbv=
lf<br>
zuh-cWy8^0XtNP%WnbNL-c9p@=3DaSSP?^vt$4IPA?Ivs+O1eGPXUOps&gt;!ZdEK+qx(e$<br>
z+4byqqU(@BHyq8cFvQPudGdukDKWBp0&gt;&gt;N~d^52N9=3DbgBA)YnEESj^KM8uJaFc=3DI=
=3D<br>
z)-U+lV03s0G|aZIl%Q1s)2o&lt;21iK}IR&gt;pK%n|4Z}V7lQV%B3X=3D#`9lCtTq=3D=3DGt=
Dht<br>
z8XOs~z(-!eS@}!v3Tbsugw+5}*c=3D$Vz@k;LUg9@QV|r$+P8wn*7;V_V?&amp;IFVx}Y|O<br=
>
zn4mBIrrN%MkCUC6!TZThVi%I|op6&gt;=3DOUZjVOlY%-F&amp;!SBkhfsBO9%pTr!ZxUXRZq6=
<br>
z&lt;P=3D;;U~7zw5Z2r`xw;yL#gQNUd~!O2^84?yl5jM05Qb0kzms_rt+T0uWtn|Keate6<br>
z))oS+U(nDLoa)MuI2blxhLaE%#sq%b&lt;_uPVp(&lt;^KiW)IHoSMcSQF;`M1!I~ppvjnH<br=
>
zD||+PmF_KuB4oyFY*?H%=3Ddu|y*(E_p#SQ?eA#)&lt;c1|BQ|luf%$VJAv8ZuTmG8T$ud<br>
zH9(4yZusHhrq{J1WavgPO{uRjJ8@&lt;D!a2#Xl53-@^n)ZGua#!%mn!^^_fL1Hvt#gA<br>
zGiJA8hNb@6aRfZ^e0b0NK&amp;%G^wCBL2fQ}Fl0*%}|gj+oXJ!~MXU{v#S1J@WXOe56u<br>
zWSw6(FuytI0+%E=3DCGrlvU(Vz)oCr`EESJf4n^p)&gt;jMos%&gt;XhSU#TX4o5XB6ZZ&amp;=
;|z<br>
zw&amp;SI-o&gt;&gt;i#KRK#tXt!cRjP+=3DIu&lt;rHf@$QA2huFawqMmOlg&amp;6WX4bs`S=
@;0wAew&lt;~&gt;<br>
z&gt;s_UyqkuR2aUEA4UGUHmYpF(;qxtIaaOE8b&amp;X#?k{a(hf`&amp;FRRo#~^Xw&amp;Lf=
_M&amp;2PZ<br>
z)+;|HIKw)s6S&lt;%qMbkD&lt;tLtls!M_yCW)(U@ps@u*;i}l&lt;Fb!B+?2x@^#`Wd&amp;r=
&gt;cNt<br>
zL(mM46?3vUShZXx7xp0T2zQ~9GkIA8r%&gt;?ftcz(BFoJ_+k3Y9pKZBnK&amp;W6y7V&gt;61=
N<br>
z;cv$1daCHD{zzvwF2UvukyU5pmJepXZ^)Z!D(XDCO1H2nf~S!czi2&amp;s)Q*paF|REX<br>
zKpt=3D`6RW1Sw}TFIc#{!{ASiVM4@VYwQ1Nf^3U&amp;urIAgafz{fW2AVkGXqYOOt1`y!R<br=
>
zJrPwMSqi0k7vY3r2O?mcxc~{jkZEGlRPY{Tm~`#5Le?#};!uDi1RY^e^cg24sxycv<br>
z7KPB(Tyz6F7cL-jciXgiK=3DF7d5_aMVUBUq#1eZeAu%`!&gt;z@5gM;X81s&gt;Ya2a$7U34<=
br>
z-3-+`u!a4TCN&gt;Z91@4J8=3DqAq&lt;7EpN&amp;mau91?Eb9B?%xL3L%ODLV)Mx(ETJ;qZ1=
-#m<br>
zp{+jotvC0~C;vnxMVi@i%(uCy*6VCj=3DgH*-1;7y6`t%6Fq2&lt;x1$&gt;mre+|x9`y{N~h<=
br>
zIxQb@r8t0h9GF@wdb+B4a^V!|?^K5ug$?}eIh=3DgY%jMTPQ*|mw5K$hXtBhfz&amp;KYI%<br=
>
zvKZKx-sa|H1)_zVRNlT|A#^;lw8iJ&gt;;)MC5&lt;Z9}7)~3l~^k6)8u&gt;QE9h=3D!qB=3D=
DzJ5<br>
znfrV8-%zh#W+7iAXNN0CMGg;-&gt;s9q`w*sQ8yQ(6uG)!H7&amp;IBIE${g~j17OSgi8uh-<b=
r>
z0W%7+u-y+D*mf-YZLekj46$C1&amp;FQ^NgpKxXV6-oh|9~WmDhOo7P86pwdD;GsWHW_V<br>
z&lt;Oe(iIpx(LgcFWT0P&amp;O&lt;sKOC~o6*+u8j7C^qlMb429w~ssU30^8mybF%-66HoVEl=
T<br>
zwj2+T1;nIEVMw*BuzR^vJP&lt;xmu1&amp;#Bw&gt;1&gt;e4zoVcU1vmCW4b8T$xPGX)P7|X8=
uI~#<br>
zsJh`}*kRFx)*=3DnyUM8F(8+^Cxn&lt;7WBMkAGPOxSKq;S-4{Jys&lt;ADg#9*gcD)hiH4sN<=
br>
zjuzy&lt;0KQ8O7dTT*`9}ZPh|MVF@9Q5SLn``ygo__u0dHz|4LMxxNR7fGka-|XE`Hg`<br>
z9_=3DV0%oR7P+tLTx(*x*zolGFJ=3Dty6pa5jt#*^L?~vVdP}{WZK;!;7R|Y%yFiu1p7=3D<br=
>
z0KHoq)Sth^(P_jQOP(+k*S`FyVJ{ot^+zCtihWUEB25K;u#j8{%|3=3D)qrn2@D4&lt;qP<br>
z8#L(0(gwuxL4Rt6set_Iz1V$`U&amp;baL-57ChoR}29XD-#+bZ-NMsNavxj8J&gt;&lt;8No+=
^<br>
zjL}19U&lt;y=3DzpmU6$LJUQ?Dg27KRU3;VV&lt;B2ocSe|yPIpLbW|{wLtk)&lt;Q&amp;8vm=
W1buLi<br>
z$1%G27cjbwxGG^yFMvmjW^*CCVU~{&lt;UWBLT!c=3DEW=3D?SnTCIy(*qDY0HS1Y)qlJI+C<b=
r>
z-AuEXqR&lt;%BUt=3Dbhq8f_uN)zae&lt;d}$uAQjTIWFvpK!oZ7@k;jz#?^X6Fml0}(hWNoe<=
br>
zkbTlx@V&gt;r&amp;{lP0K6V7s%2$*wI?piD!Z?!xT4el8PDBO(v${-Bw1q&amp;w1vaA6UAuC=
gX<br>
zh7`BpDqX__53VB{blZCNs0|toV&gt;akG+~nAl(&amp;+?-(cWF|3n;5HI^Sc5cI`TbMUj@+<b=
r>
zX3lP5%QDtc&amp;Mh+sL0~aF=3Dc+suW6sCv&lt;|6i6O|6wIk!(WoL&lt;)_^er__MI9kWqh{=
WGr<br>
zTVaAilA)bId0uQYds`r|gMdU(j$tSCnF`0BTs)uruWa&amp;&lt;OVzA%Xl4EOgUd5iup!qF<b=
r>
znHl+cxS#Cl%#kRE7_HeEa3K_`3!WD&lt;9}0Oek{i@yY(NcvhG;}3;VDcQxo~djldEj;<br>
zGr&lt;8&amp;Rd_IR4zuBQpQ-EZ5`qoPkd_0Ji24DD;)$)=3D&lt;RCX#6_|%6g3@FtDh~UjKg=
fp1<br>
zaggos5LyWWyIE1zoFz_KkKBYZ5PW7q)fM7?lPMpp&gt;Q!Sg#vXQ%TxZBcfhI;&lt;M~Rxs<br=
>
z6l7IS4mq{j%cJPMBSaVQf7P*qs=3D%meiv)*zMt`KtNovK^vdPASnf)}gqe$0AckNvu<br>
zb+E&lt;;9{?&gt;rI!+E-2lA5gNjdMd%-&amp;vQ+X?;w%1B@byW&gt;pWc2@YZKs#_v=3Dd?7=
qgqVk2<br>
zMFR2jYlPi_orFW^;#gP$-x8BX*^g~l6f9QFEg=3DrvGI8vU$eRNO&gt;`~T4Py%ypAWKr|<br>
zXZXl4zaz9TQ~3jE;dJw8E)VijBuzd5F+UiRJ{~^%kKN}dyQja~J$pJ*wqj9d?9v`$<br>
zvSgqjV$H4(c!n6#Z1;6sbAVIbRGaU&gt;8Zu&lt;2!_+3c`9H?K18{+-zdL|yg@fh09bY4Y<br=
>
zr@?d8SDyaP-6AH(+z&amp;jdy*DJPEvHCw%nebrPr&amp;HlFu22sm|0mhLq|R%%Q6~dVquqx<=
br>
z(&amp;j2HEplw^X8!Cyf~lRH)rW`mWHSC70bgAMZk*XLlT%zB9gY84gT&gt;S-%ugH^`1=3DrN=
<br>
zKHR)Dmx(MJMsigl3{gaduq&amp;t94DydlgZBJ7NE@-yM1b`@Q11&gt;RtW1mJPKpR*Pdgc!<b=
r>
zl@c2|(rqfyZQQdD&gt;o(T(!@7;N40IblQKN?rLNOmS@pv)7(U9A~{|lzugZY|h*3le-<br>
zA-53;t1iJzEXZ)`nQh!p+Y0x4yrW;kgm4=3DsdY6TKtn;~ch=3Dl;DIiJnbtXX1DuBzpG<br>
zFbzwin$oq|k6l0YlO@i=3DR5$7YGmAzewzt(XTjTr)wJ&lt;lw6H`S3?{QK8KwgdDP6c`|<br>
z%541=3DUjAJcC9Sci0&lt;wvNaH(3D#Z6gl^RHCP`I-)*Q22}R8f@j498PAWu^{U`nW|*t<br>
zy9gF+;DC#6T~)|Q2d;2mGki!ZXrRgPP3I1bmPv{W-az6Ku?DgB&lt;L;mjaQ`?jJ08%n<br>
z3mQTWkT499Dyzn5;NIR2D~LL1W_(&lt;X2kJj0(aRll+?I&gt;E_92E3xtL&gt;*u?(jS1sRn9=
<br>
z{2q6)WQieP47q36byAn&lt;Uu2NMfn0Y~r@G&amp;PjMT7t`qlHV|ND#YUw`*s`_2&gt;j&lt;=
=3D}Xh<br>
zB1bDtY)mg_&amp;ogJu&gt;*1pwB`t)rBCNzY$d81&gt;2D|~h5}X&gt;r&lt;h-D#o1XFt5jq=
u&lt;%(zF9<br>
zQBby2?gDuN{m5b=3DBb^i-dg*iGlJ-mFV8n)e0lwxuUmW~|^$4nh_?Ly?)I|FpvxY#&amp;<br=
>
z&lt;B3j0N0wfBy~s8IhFl?iyZDE@a#Z6qK9bLLvW&amp;R5E?UhzeUK({n~t0*&gt;G0$T;`|C=
y<br>
z^k_}Wg_sX&gt;mL}(#c852U34WN$$H3VQ#NF;TJ#%uMAT&amp;TqrXm24$RDs(vFS7IWkVEJ<b=
r>
zf6$2&lt;5{5@JNKGR&amp;=3D(=3Dwy{lH!j*jjQZYaTokcMa0x&gt;=3Daq&gt;3&lt;m+&gt=
;Re4j&lt;WQCUp4;f!a<br>
zQ*r;k!2u5FE|kge(_P)XV7^V88P21f1rZG9wSRKGV4S&gt;!*j?n`P~J5B{i=3D_KiaY!C<br>
z9zl4VJo9_|f#b8mOdKCowae*YIFPu&lt;L*2_~kkslo;L$-_Bu^OXNuIO~3f52(R2Uc!<br>
zsh@gyLNL5Gfokt=3D(K-dFdWju|I1`2=3Dc9n&amp;D2-J&amp;vs3g}oL(Xt3g57CPC^D02yQ=
QC~<br>
zP94J2r+aD4Mi*5&lt;hI)jK;k)Ri7U2a3GjA5_DaQEm&lt;IZ1hOMCJM(qWX@^v5&gt;#U`{*&=
amp;<br>
zoqUXhLP#4PQ;5Tu=3DCyY#n9X%|$g#+fU)fmj3&gt;o9H&lt;X8n0=3Dz0G`VmblGGwu=3Dt(s=
0vE<br>
zX{V~h&gt;t)dpu9Qbn1Xaz-^d+doe3GD(FX|5xba1S9{gH*~c7$Babm32`{QwbNwjd*D<br>
zXxe$_eXaczVYhF6@bZP(DAL%IyPLaAkq?0XX#*#uiMd(OpXjqaKx;A%al`qDoS`?g<br>
z6bWi=3DGP_SeH6l1-*BCQxC;agYsb&lt;evZqVscaz8b4Gg2dZxGCPQu^o{EBrPM%5msZm<br>
zeYhfqmNO_!JGUk1d~Ic}9h({PE3Atj+&lt;E2b9h5%8YQ|pH0tX@j;j&lt;)h;q`vRwilTW<br=
>
z*w4obH;SLM=3DL;Y7y~)&lt;ts|Lvt#WPF`P?&amp;X%I`4_=3D(Sc0;3V92U)T8kT(e^xmMF#=
)1<br>
zICPokEbg|H*8hfGybxLNKfnjIXdn8qmBieD6cJ{Erh5w-JJKG*=3DcJ2O&amp;A+X&gt;#7_go=
<br>
zmerSoMx*ERN?&amp;aA0Hpd&lt;5yTyOW8aV4DKH$sj`$!XIerDGVh^|HZ`opQ9vva9{!_P0<b=
r>
zlt3SokEnC&gt;O1PZ*G)@7^UPN!ftRE8PzX%C9AN5EmmQGAMw4$WMg&gt;XerrwWr;V~sn8<br=
>
z&amp;%%zLA3Cl?7$Ul`#N)p-`Pn{I22Xhb%#~IxcDg`)h5HSZVdQ&gt;%i!Ae*Y%1yAuj&lt;!=
0<br>
z)OL;1GkAtI3S!9{&amp;7}b*g2PSR`+Le&lt;62r2m_rbpIT?QKS&lt;`4++c6X-Uo=3DcLn2a=
nCi<br>
zaA&lt;+Ah&amp;}jM%UoPG#M?ky_hJp~1u){=3DUsb5s0zko?16Y5LvpSSCgk&amp;f&lt;hgQ=
wx4_Skh<br>
z@+(A&amp;VD?&lt;Y=3D;pO_0Oc#$&amp;?DVAb{?I{sU_WUgTJu)+dQl9ws|1DVx$5@-LvkZV=
UN{0<br>
z4ois=3DE_O4)Hqnip@Cp({wNA#TCu-QYeO?YUJa4XJgL6&lt;GF&gt;vlk$}j0ThZv0nDLc?G<=
br>
z!(i{6#?29q3yRAqa-Fqfg+bIE9vrH&amp;6U`1`S&amp;IKp`&lt;6ZDCmauMK?FXdz8)Y50Q4=
Jp<br>
z#TvvqkIJKD^9y`pZJnBxklt-kw#5k0-3M_ZwBY}1fv|T?NT?=3D22p@jIMM_#|fB;7q<br>
zfPAp5LvC%n?Bbq7n^xf_4$&amp;bWVnGF9=3DuD$}S0)Z`;9zE?SKp_)dsuNm6j;sohSXwU<br=
>
zKU2_zh9lzSD~nirU=3Du%8Aw}o*D3+W@@efv2B&gt;2HUk-*OZ2EK@*3w8M5!=3DVKk%}(HZ<b=
r>
z&lt;q1ZWRVs4oci`S{r5W%j{m1XksoGBYr-MlvOe6%Kh`K|h&amp;Vl^L4gw(2Kb$Cgmn)py<b=
r>
zM+p$273U{Il8|^PlbKHtCO|j&amp;?BMtl4H_13N)=3DQygL_kOTYey+ft*(ff?&lt;$BU9Utb=
<br>
z3J&amp;&gt;(9E{qrlYS4Q_H3*4zIp*EB=3Dl+v$k7af=3D$^W3*k9(49Eh!ko84rQo1PT=3DD=
n&amp;kH<br>
zR-!iBKk{UpAOhLs-xf6rs&lt;_+VAaMi-ATAP8rEYM5o~n=3D~3pB((oCiKm=3D(rgd^`NRK<b=
r>
z&lt;;@bV6Fl5hHNw|4)Rr!PSr_HcGwyK-Z_a)4Su(po{sTx1PjSi%e+wFWjfxle2VPdZ<br>
z;`m2SN4ogyy9vrq9T%7jdMT#32{c7RjbZDpX|_08JiE9YU-6$U{YCzf{IksIUl2I`<br>
zli$+c6}MQO^6#ho_Zk2Fod5oY|NfT#7X0V-1~ZT~WorVJz5N~MQ)5z+Mvaqh+(BNw<br>
zp}z2H(LXi+xka8S|3ES&gt;|9i(1hNj6^%@&amp;}fUw8b6nj*a|J^pccKEwZ9B=3DLNAn-%M(=
<br>
z+Fdsr9L!$tu8TEtVs;ll9?p)&gt;Ke&lt;HduGt0s*gYAIj&amp;BN_y*vJqFq=3DjwZnK;Gug=
Cax<br>
zb-UT!6xX|-Hu(+y-0U{x&amp;8{h~uXm_Ww;Ao;!s@NK&lt;t??i-F&amp;`7Iy^nR9qqC^RCm=
#b<br>
z&amp;u~BEXVvBoK7;uca%O+~`S=3D29KPQtfj*c&amp;nQrbm-@Ze6uYoy`O!Gp3|=3DEQK3Z~=
twD<br>
zqJx}s%bDJjQ=3D|ahKskE8-DdBH1%h&amp;FbWBhbF?y1LgP&gt;d^4s}x{I2!WL+4?S@-ez&l=
t;v<br>
zeT%2vyK79=3DYT{Mt4M`!ulF~1ng}_o=3DLmQNo3=3D6DW(7FEa^P88yY~Z&amp;p5o4&gt;7$=
|KI7<br>
zd3lD4hDS$KT(8iVR~O}_&amp;HLa)r2x_$&gt;?J6ZhSxx}-=3Dh;9nQkonZZQ?o3Beu{&gt;p=
&gt;Qv<br>
zlou#0g}ERRM5?2cZ^i9KN?CE&lt;!fv&lt;kiQ3D*fAfcLUuaQ78?&lt;4eR(TaM9&lt;!$&gt=
;Y*b+_<br>
z{8EJ0D-Mu~eoL=3DN8wc_d8+e;hQ6yWJ;Dv!3z^$&lt;&gt;GJ@u1f`LHs0LZr}$E6_8&amp;b=
IRm<br>
zAZL|%oz@o_=3DsR71JYKCRCB_h8sk2(Mlqyh6C9i`C`hX&amp;)w@EKh39TwofCTwinA_!U<br=
>
z2ja~yR{Uc$USOuz&gt;C$GpIJ=3D%NFw?u?@?rtb0IXcA0zieG_+|Xa%^k9cY5=3DYEg#RCb<b=
r>
z*OA7s#-S1kaJB)&gt;M@MhH{^KLsggRj?S&lt;9RG(@J^CHM)W}ja1qU?r&gt;oVE*uuzv|vnd=
<br>
zt0&gt;!z3W%N|&lt;a4!diVbur5cR|SwiDRA?G0&gt;F6~tQ?giY^(Y@l%D&lt;xtp?&amp;k&=
amp;M(4W%!U<br>
z%ZJmQYZyh&lt;c1EG@9OM9p;q22h2!a8Npw!J`K!V3#e%aGzlA$K-yX4EWWAyKBz&amp;4y~<b=
r>
zz|B4#tM^wcaUjovYW|E_dXOc%#KGtHvy(BEIiqQ6dSA|Sep}@4sCMb&gt;-mL`nMVIfL<br>
z0X#z$4-@4C0Q&gt;z-$tjX!C);Pu1Hk4(uCxacYAE+%)zr4%BA|&gt;fY74p@CT^*Af#MJM<br=
>
zg&lt;1Mqt|@a_G+kSUSdQkyw!4RiH-Sr^l{#?z`WshJmpqH@P9yOQv~T-k9QtbY(`fX$<br>
z)7-$Sp6&amp;K?U4WtRJx6b7ml*l!2X7~Sh`&amp;7alLVr|ab#?+RY$a=3DQ}#-mNw=3D2o-|=
W%f<br>
z2GV$Ni{Rtn3MGcA(&amp;}}Ag2(Sxc?sbJl`dNs|A0#XPECeAZQW5aK#gCjhOE8@o6kT&gt;<b=
r>
z;T(WV8}pN&gt;y92i(uhl2U!E1;+FX|?fxiDSGKgc)|KQ6bm#!4viY@RZ2Rs&gt;Uv5D1kB<br=
>
zg&lt;QusVK7@1d2R`DZH~a?HY@K?An+hXZB|kwveZ&gt;Xs?QM@w*p3RI`byMX9=3D0nX~X4;<=
br>
ztPN@jCoN|crkx!n(_cAfuppFCCIGkyd;o{-uOE=3D7sRKTUBd3iyLJ|L^w;{y*!C2l2<br>
zeK5Xv97#dw*(7&lt;d#GQuhpEsmllan#z8z65z{ubm)Ig#iYbEns9WfES}n};h#6S2S?<br>
zK5C_6&amp;ZK_*uB1Fnq{u=3DOgk9884(Ze;_-Wqc1Io%%MGMCRJFp0r0f#SwNJzA0P7EEZ<br=
>
zUBC%&gt;KE$KRF(kjzd$RoCsptD+a;w_~r7=3Dv633Cq&lt;J2(XZ*S^XiG;*9d=3D&lt;p4+k=
a3Gq<br>
z^Gu~GatDM0K_s6eZ&amp;r9~w64hAV0Zy;E62AP&gt;~=3DTMZz%7rLb1z(6zN&gt;U0&gt;4s=
93K+vs<br>
z4iSMdJdhx6H$xqn-w`mq^JaDfFhpSu0N(1-21LfHtQ;$#a&lt;uJ%+Jgum&gt;B5TYetzT|<br=
>
z$+Q?Z;p}fD5d%&lt;wO)gr@h2te0F9vfx*Ql;l+PXxY5%MHJwL!Xx53y6o1P)33gEI|N<br>
zuRM*yi&lt;F)-iz7&gt;btJheGa~hG0ozvjHJNKZ3WTkGwN$C2mJDfshTD&gt;Nek(&lt;NxIy=
kKC<br>
zO^!n0I_ON-Wut*F^u7W)+##A2^(%qg8zhQ*bQ#^7z#)js_9}?EDmh6G13BuhiiR7S<br>
zPSH!4Ir_n!?&gt;ySgHVXa!f{P@x9zjMNZRB+IU&gt;iUbACF!%{Kw!IaY2t?5^DS~e#zuR<br=
>
zgeC-&amp;-dzOaceD_USh3%F;X=3DglTZbRotc9_Gs8f&lt;shmah6OI2TsB%07xk?Fm&gt;H~=
t(B<br>
z_j{r(IfVKSp&amp;YZM+kr9RR6%p*bp1(6M8*nJw!&lt;aLZoHm34Ae1xKUm+NUcHcT3h8_r<b=
r>
zG67k;6;j?BmxCvN8$uY-yu;%i&lt;jI36nlG&lt;lXjntzFV5bgoHw7)rYU!%h@py&lt;u@LX3=
<br>
z;FsAL&amp;P&lt;Dycy~L{;&lt;&lt;KIG*dvhrOms3@CzLOwLZ`8n(7??9v4vfG6-E9*ul}6E=
f_h~<br>
z@HP)~Mn&amp;zxlF3q}WIR`;o`Zb23#*LcX7~rWEqKZMS#q_mP{AK5a&amp;G0wvhR~$qN)ju<=
br>
zZP^fnbaE@-B5BX18+2@+2vV*KGI4NbD&gt;xq%!KA&amp;JhOXe&gt;bfQQSr6Urcjaoa@`L2&=
gt;L<br>
zbwC$dak;KAhB01-w=3D|*)@w63U+oUzT96TK$p&amp;Lo&amp;XExqw4y@3`@ifI@5qutk)5wp=
O<br>
zUoP|~x$HO4#ObfL!OzL^YyrRE=3DG?klNiuE1fx@E|Mqx*+t6Rq9%d`#so~$qq{W#Z&gt;<br>
zX0sZ5uCW&amp;``M-&amp;FmAxm|Ze3qz&gt;ji(-Wciw-JHvXs9&lt;Rnrr8EAR#CP=3DR1oA=
!%ukEPT<br>
zU6(Z#f%HZlV&amp;eoZ1Jf5UKwgSe&amp;BgJmK;pBTCQ-I8XCF~&lt;6&amp;mrw{N|C21+a@=
i9np-x<br>
zecvs(+moQs&gt;ysJH?qDXwaz6%$hXOmH)bC3|UYHn4zcb_Xfiv*6;FcgAoPjQGjH7rI<br>
zro2UFOi|J)1&amp;}ZT#oz#YnlL_an|Xog-XFmcm&gt;-~zTxWC*$0BHn@a+g_O&gt;Wq0l$+0=
B<br>
zkV;SwCTgPyK-0s0GqUb#Sl#hANqCAV-Ljc+B%Y%vWCT&gt;3kua9%Hob~cyWmL}q0$)k<br>
z-0&gt;Jv!z8@84WYs@ML736fSM}}L4jW%q^K1pZ&gt;0=3DJEUcWYWw4dQ?mw%aN%GV3&lt;%@=
ic<br>
zPes5i8gIvFyb{7OaL6TPDiN4g^bd=3DtWqORCJ0WZhvB5{QNtfqOKa)&lt;A&gt;S#No3pAXR<=
br>
zM{977&lt;#`eWOhNy0C0mYkF@-#ZMwzE5`$j+jXCgMJ?vIifaHUdxwovg5n?&gt;kHjxHXE<br=
>
z-FZ|o6^K+gzJZA)&lt;KLWoHawj)$NA_e`FEu5Y7=3D^f&amp;mLf-5dWbgC*cddsP(Tib%ft1=
<br>
zsIIkez$(?g7Jq}u2yz4JM+NLwU{1noOS?jZV^0G+GQ4e_#H5syg9)I{K39~&amp;h7`iO<br>
z=3DxuQ0L7whwL3MxG(HF5w&amp;gNsqz1j?9zXt@Cfu?Q5kRi3r!^CUnm@g6sVV=3D&gt;%p8!=
0N<br>
z!d`QuUKCx8#Fi-*{9zd)3s|WEZzOJLVjSj)@mA6)?YFLjyzL0^QWgDB-3bmP;{BR-<br>
znH&lt;4RBAtp7{VDAV!cXShRu2)3KIlJMZK`pr9v~4mm`Goq8F;&gt;{)S%oNw9uPaw=3DbP+<=
br>
z54WZxtUUj=3DP@$Xg)|nf~Z(oGc2GltijOdmU6(zMw%V6P*D?o&gt;MnYAEoX=3D14)6KzlG<b=
r>
zw~o;F9Gtj4Jg_&amp;s)ul(T+=3Dr95fEuBkr@?s9fg0nxI&lt;$p5$&lt;&lt;HR{U4Diz!zG=
+di~;m<br>
zvU#sXu{qTNqxI%#kr?N41Qb68izd`JVFG{7_@4C{Xnm5*MNZf2W-L)=3D+!d;u;QW7u<br>
zAfzz#GF1of4}bp8mlFB|&gt;W40k&amp;U47r;+$oaDZ39d)IG=3DCz!QWM16wk&lt;y!f!wtT=
;F4<br>
zaoe!*XJmFe*G4k4xa%9pLHNe(H#rs|&amp;CYe1H!l5~mraT&amp;$J602k~xD}@eTBgsz1a)<=
br>
z%OJ4u6|aafV*}dSTd=3DJZcSWU*dqE6SGGR~)R6zL&lt;a^Nvieu(w}l{)Aj+~lbqKb;iE<br>
zPajNg4f{&lt;hk@I^x&amp;?saf^}PwBR&gt;x1n?vvtS#v2t+soT&amp;d*3!rThF&amp;q&g=
t;0}Im6P-Flr<br>
zcP5aO&amp;=3DRialzJtmlBK_Xe!=3D9DHB!5}ecMvuD8Wx^3lll+wI0B6kC_g31T;JI4?hM?<=
br>
zbqg7QxlZZ{GIklipcDy|{H&gt;#EzCD962uq@*zhoGq&amp;vv%{l7Ag#y2l{Jpn&lt;y$rHNB=
-<br>
z`Hd?KPZOEcFphM0&gt;!V`6!W-y5UP1rh9o%X)TjC`=3De;z$}hVdDTCeU9DoE`LKO~LO|<br>
zFAKIJdkSdh`+bC~f=3DlBdlZM&amp;6sSe1I=3Dbt`XK&gt;w;S4i-lrD&amp;bpQ0)y|t&amp=
;kwAUynFPa<br>
zrhoo(c$)wAGf{MLYNNU(kE~-4*mC7lU%h`t*&gt;7|Ab;p()9NK|@K~Rp6)CSUTO@%OZ<br>
z!tl*J?$G=3DpiL4d2g+3-X&gt;IB=3Dkg~rVOW_{zh8%**V$x;J|wEPzoz+S%}oDK+;);PPi<b=
r>
z9;is5m|7@nXrA%DvicdWDQYfHWy1VhBa|2hDyyEWHg%30wDnQ(WQ8x_(R^$-o(^0b<br>
z6!YKT9wE+9-Ib`^OHC9oEYkX2IM^r&amp;1d`dUSA7Hc_c;Me)0{)o8ls-iNBZtZgv#&gt;a<b=
r>
zI$k90k$#2l|52m&gt;8q~QD3s90L9jJG40=3DWSdH1dBB&gt;FYlnIDtydVuTEL(!YtYy72&lt=
;E<br>
zX4kf~wvI6vp}it!?7fF$$Q|ZU2!TQ4q6mCNO195+f??$KWC(v0NP_k)y07ZZFM?Q&amp;<br>
zDaEY2lLALb?)7iE)=3DZG;6TxW7F_}Iw@!%dS-S9Q6;0V{unE5@-6~9m*jB!k)4e@e}<br>
z&gt;OX80Ns=3DuPj4F{S9l?F#FWh?uANl=3D0v11UOftl?*f|le0bAHbU{HPG^v2J2qftFC3<b=
r>
zlGZwd;T04UyJfBia~6f!RoR9zA&lt;8z6_DIcHJ}eflE6N$Zh3(;&amp;jGUvd_kW`?Y?+D?<b=
r>
z`p}bb+WsUk3FshH?30ir3useq&lt;O4O51q3;Nz#kD-z;zgO@||?&gt;pJ3LO)1UAqEqt!5<br=
>
z{Vmm?!U1Z|xKh#KOG1#i%%btVb1R$2(Wmk-xhI^f1FEDn9+MSuc9E^_vFsvY-j-Fg<br>
zdS;nP+E*&lt;kJYPMFl8)&gt;-xri}|R@xB)wnNk?cL_g8k^YFqyXFXo2Rsxh7Jeks(;i6y<br=
>
z@bK=3DO2LW&lt;%iIG595O%&lt;xBDu^A(6ku5gOwiG0eZ9$ceFpwxR?QM^iF;Z;d_XK3k4Lh<=
br>
zU&amp;UAm#EN=3Dg&gt;&lt;%#%@^E+&gt;N&lt;lp+O3$;3T7lHS_f7iR2Cz!xohjW0wnKoae=
Vm7~4fLD1<br>
zT+tD!#qinlXIAlrPWk5LERi4qN?gLXD_;WK_ipc|QPsdE_Yv&lt;#fCN6C0-o$19}g6p<br>
zu7d{_CEON|0|F9xe*=3D;_;PC-|va_R$AE8d&lt;aYA*W5GCTl{1eB&lt;p_v58W{wNPx5u&lt=
;*<br>
z2f}^ovNnLU)?cy8tT$Wh6&gt;%7lLby~FmW+Y&amp;yHEWywU5oO1{4lfuKPX@FB}X|Ez4QD<b=
r>
z5_9jbhl5lVP-IJ#&gt;B!jl{|lnb22)Y?Xg!=3Drl!faG`8K@u(W6I2S=3DiD_YxRh-_D8&gt;=
M<br>
zvm{;HLd4|a2tI&lt;%+0N=3D;dm`4TnmGJHVLII5%pdAHI&lt;L*cF#{O1r{d#&gt;zBp_NbEz=
0W<br>
z#t!A61RZ~a|C*~eq2k-%OB8ogHHqUaHFB5bTH5&lt;-`K-?yK6M;q^2%y{&amp;z=3DygD-|!1=
<br>
z&amp;kjj5a^1?WdV?@BlR7FpF-k+sEb!%0emQYeV*mIA15T&amp;mBjIwXO~54_)ISn=3D1(#a=
L<br>
z&gt;u0hbePd&lt;I_fQ-aqWFNi1&lt;m#G4=3D9UEZFY*h-SAVrU|2t}=3DR%=3Dtiw4(&lt;_=
=3D3zz5eg=3D`<br>
zf&gt;?U(c5G+gX86Jzft1guwHtZk+t5%)i-rQT3a6)=3D;}}WAOyT9!m&lt;_T8(i4@tA3!l#<=
br>
zh_04r+X4X)fl4v`g+EcE&gt;uIl^tUkOPM~;yAiqB+QGDHh0rP~`6?=3DfVPlY1;G`Q1iG<br>
zBR-B00AEB#7p3$l5(_zTL(9i8z#ET${AB8aUnqMB-NHNpg+yz~^+3Pc=3De#a1&lt;Wtq;<br>
zm^v!Q`6bQ}kiCR-gBnTT-cDmB+VBD!JjwBg&gt;h`og0dF2$5Z@h0i&lt;XLppfIg55Z*t%<br=
>
zWK$vBb)~`1uA9)@59YWiw%~lA$o&amp;wYI`+Ahb1cn|iisd`wCT&lt;XY+EgjYq+twwQ@3Z<b=
r>
zDTa*9DUC9qpx!}&gt;J&gt;j07|5Rs4cvR?S2Vku@P+~_-CIFLm;IZkm&gt;2mA_AN|SCN&amp=
;&gt;HK<br>
z43S_sfq;{;Sq?px++-xU#T_+oD4!ayME&amp;zi4EJS9A03A-ihqtyFL5pi$MAAsZN9|k<br>
zB=3D9o2+nEk^ZjrA|)$b&amp;1XI^zQKQ*Fla)kS)E5kaca}-B*{8K~&amp;RX^v?&lt;!BXjB=
O^2;<br>
za^ULdTnin0PjsMXSP-{g7Zks7#c*XBu;1|IZ21UIyQ-sA?qbcnfO|#j@U9W?vr^Z6<br>
zBZA%g%nE};ESp-u;^lit;k%~7eQa@V6@Mz5LOvPcg0X^r&lt;HUUiGS;YVnRdb#r58&amp;t<b=
r>
zB;{M%f}N0=3Du(9Lkk-DQ_+;*)Wx837`Oy$8RuPwGh$@x@LF@g+x9^{i#0ZYWEvGw~?<br>
zn4^6c!&lt;D-a8b-Vmsetl@4KN&gt;eXy9l%{ntIQinO8xx%&amp;e$h!#l4r(rU`ABMTWNJ_O=
y<br>
zK|o=3Dt@{g&lt;sE8pvBDG5z&gt;1r&amp;_c0J^6NfF5WLEk(06NkuK_O9Z2btmA&gt;m_MT(=
nqA^-f<br>
zu|JQIiBy+LY}X_H-C9fdD)w{n(-CXu&lt;}xxNMVzmIs4P;lYBeAr@(SFe|J!S&gt;82cCn<br=
>
z)Ql#XYJF7N(Ag|+`;56_{|s4G4HXmyuijcdrbYD`uF!45uRb;`#lXs4Ydc}x*P1c|<br>
z&lt;&lt;pRefg-kYgHxN7tmrOaz#NbY(fwQx&amp;fcJ)anA!;Nd}}c&lt;w$+)WF0$x&amp;P=
?C$1VIJK<br>
z&lt;D$13iy3BAvPwVb&lt;+JOltfEc!p0EdL&lt;1WvDSJ?{^zbNfQfZ^hEJ$(c)Kt%)qLkzR2=
<br>
z1+*lGPKm&lt;kP`&lt;bhz8pC2g^h!F-1ep?;8dnaEy@G+I3bw|NL+&lt;4+&gt;IwUE$HHp0i=
y^O<br>
z;1TBFC5BVJv$1zZa2PRec6&amp;OqKSjEmw34rQ;r#d&amp;f0siPw$=3DwP4(J;&amp;JtFB}=
7zxQ+<br>
zC31LxpHUiRI665{DC;I#yMPI^FnV*MO)49E85r&lt;^4+%i|V#vR?3T%D&gt;rsj9LMCNLL<br=
>
z3JN@gy|tZsncoPOE@j+Ct0$0{VBE4-I=3DjNB1j#*}T|pSy&amp;qxd+-mfhl7l78vL?26)<br=
>
z;Nv_bRp8=3DmRi9LuWx_%}ID&lt;)s?7&lt;&amp;vgTafL212tJ{a`?{mCP&lt;=3D61R``*%=
WKkHuw~s<br>
zdL$)Wo*hZKil|$)Jo6^310V3pd%9tu5DQR`XY53P(&amp;&lt;~O*&gt;K*g^^9igHrHg98IPx=
Y<br>
z^ohtOeE5^#Ct3^vBfCb%Q2;_5d**`BJkny7FMhTZ0d*e4u&gt;AP$e&lt;_+39})PrLWOG@<br=
>
z-r0txS@4%VgzM9+^03JEUAZa3a@@FrR{ole-cZjEXADa6tnVX(N&amp;@MYp2Dkq#19v1<br>
zFw$Ce7%&gt;7r?8I1gw3yZO`&lt;Fkwe3K?T-hls7-mU(UbfjeLktMws+YBirve`3HHXqOi<br=
>
zo2qILS^cPK7sQ=3Dm+)73c;iR5!P;^mUnJsy&lt;_{@_VCM)r#S)Y}r4UrZ^)-;=3DZnjjnQ<b=
r>
zuGwwn8Q2~_ryfB&lt;5X*nT1lLx^J3knfV)8OxoWX4e$UwKU-ZN^Dou$o$jwsq)rn)Vo<br>
z3j%k+@JL_To|iKo#e4^D&gt;g5@-rg(mw2X#Qv3XFS}u8)S&gt;^K3&gt;R*s(WsVEtW)r-80+=
<br>
z0hJJsZIL{)@PVj84)7rtS1gGvF#;L%YT8Z&gt;_1M-3-OF~WrRhc$&lt;bjPGn$zJdB*SNd<br=
>
zJdqHeA|4SDxo3&lt;p&gt;HKN84{@0BDeS|&amp;ZwLo97`i3I{+-_VgZF3X`i)!4@?ke4GXM;=
V<br>
z)H5M5=3Dw!~z7cyK!^Rd4vu4wm)(cHe@?Q$~dgeP+E;qMstBm#jBU@-6m)B&amp;fg5v;PO<br=
>
zIYrI&lt;Jlj2Z|J6%lL{HyDWLkH=3D8D=3DZ_k`HwY#xwRYS*hQ}ftL&gt;e063hB&amp;BNme=
xNy6p<br>
zA&amp;!7glA{`-*%8tV*J^&amp;yNp6!e&lt;ZalO$Gb(Regi?UQH=3Do=3D3*yM0icB!l!_gB=
t-Gs%4<br>
zREJ`mv@o$2+*%%|q0FZxBaKYIl&amp;wo0%fIw}!f0_1!9?1SQ`+JLKOCNzRAekDfv!oP<br>
zVkqK6WcD*f4Iy_CDPXJc!J|PJKY%G=3DK-ISYA*iA?x?e}02HDyDj)sn?q~oo!QsA)s<br>
z*zIssTJXwleZ|L+fVy@=3D&gt;CE+!22kml*IO$vt*{T!&amp;~?Bg@;a%zgU(LlKl5|U|2HA|=
<br>
B&amp;G`TT<br>
<br>
literal 0<br>
HcmV?d00001<br>
<br>
diff --git a/lib/toaster/toastergui/static/js/bootstrap.min.js b/lib/toaste=
r/toastergui/static/js/bootstrap.min.js<br>
deleted file mode 100644<br>
index 2446398cfe6177172771488ec9bbef5429050afd..000000000000000000000000000=
0000000000000<br>
GIT binary patch<br>
literal 0<br>
HcmV?d00001<br>
<br>
literal 37049<br>
zcmd6Qdw1K&amp;k?;Tc6colQlOvFl&gt;?E_HOzZeHcYW_9o*ip4XRlUCKma5mQzVC^&gt;~SR=
J<br>
zv)^C6`T&gt;BJJtv!UGdUIkbT_)I&gt;s{4_!&gt;{*#)A_pde7W3iw(D%wdH;Cuc&lt;@c9JK=
Jto<br>
z!^6XAxgFcHLB71|QR^4W)yH);oozdhj*gG}_~-YXvk%pFTdvd2&gt;qS1GM&amp;DI=3Dx!9CN=
<br>
z=3DXz0;&gt;&amp;|vocK-PKtTUI}XmR+PYSK;U&gt;7-heMKT&amp;~Kd#E&lt;q;vV7*X8&l=
t;SZ#!ErKXex5<br>
zht8|@db#c&lt;Zjui-o&amp;TM^&amp;)(+iYPIdG%b%~Sb-B@gN$=3D!fa=3Dpm6)pF6zdN;}=
SrtDyC<br>
zRlZG5-e&gt;F1c$5t$i^1j3^p?S9HLteaq?7c{k1p(LfI%?1F&gt;XD1w7)+-KfZYKhuhoZ<br=
>
z(THyC@Be{*9OK9M{L#ge&lt;J()h{q*s#opR@Wx!z#9o#VkD2FIP{x-$cG37F&amp;SZD+px<b=
r>
z!0^i!uHA2w-d$J0l&lt;r=3DwfuS?*_HJnD*{E3N*H`6YJIL2%wk=3D=3DHOS&lt;YNZj+N&lt=
;Iv(Bp<br>
zRF2&lt;O+p~4H*i;0_Ve+AN=3DhdP}(myW$9&lt;~7jY5S6%z6qZ#{RO&amp;qmbJG2a+vtvG|=
b(}<br>
z1e;H@&amp;pXwkGwxwy-Y=3D`7bF??YPHwgz=3DjC~R(OZ|&gt;&gt;-FLWU4~;^-&lt;`;fz2=
iIH?(*t-<br>
zjs-`v7#V=3DNV}VaT+B;5*(RNmCPO&gt;ij=3D?#{P65!cH9h21c?A@T#(Or*GtMnt{{_Snn<b=
r>
zEqVi&gt;-gH{7yO`_sYPDQ%amU~^z;t^y)y}5eo&gt;f=3Dn@_O4X({V4Q3EZVwH+WgwAR}yV<=
br>
z+V)_7A1^K6({^uGWnN|TL2V(Un{l-$&amp;Omp=3DwgG5*X;IG0DS_^jt!CMxn3qF0RX`LQ<br=
>
zm37C1ZMFs%=3D?$ulKvZ|CGag8vH{(nFwH{=3Dv)%+tjOVNulb&lt;?}M&gt;*2pI!*{%1_8*L=
=3D<br>
z+6&gt;AppM_v#bQ&lt;Xvr{yRg6xlYTeI8`&lt;a=3Diupm$$c#yJ$)LsL+L^3GtQ1)U&amp;S=
f{(gBr<br>
zz8K`$eBRAz+VZA{=3DQMu5s5V#CW;06UB^M8YY$3z|E&lt;(6&amp;l7mgYOVXTCV35z3n-XYJ=
<br>
z4F3G;hqtfa{ArXhmrl}RaQ4HqKfQf@hMRwV`Qs1I=3D*Q^zcSm@#S}(UtVyV(UdXc@f<br>
zlY=3Du%2SvFh0C`-+1n|lN=3Dwk2~tjnwA`?4!5Djn=3D5qjHdKw_wk_LfLG9Z*qIv_0MMO<br=
>
zastjW8BO;0Cm3oq&amp;+@W+IQY7II{NDTFaN!{`1(QbFin!45YiOmCtm@sqsi&amp;{#c&lt;=
L)<br>
z0c6Km5@Ykra*|!ox4`=3D8U|ue!+ZkRq#YA}48?ZB*HMKDMBfkHNh=3DIV1)dh&lt;K&amp;jW=
hu<br>
zu;0r|%A(t&amp;VRhjz=3DGkV`O{xW!(MBr!`%_@?Mw?BtqD*?H(;eI+?+x1cQMYwFdqZpz<br=
>
zcAqc_a3|Tt=3DyT$Kj&gt;edi-5&lt;PIE`XQU`F6P;72$)$5|1W8t*u7}M&lt;;%OQRz63iHi=
U$<br>
z9oU#;`q`=3D?JZ+%c{{X=3Dj4(ZBK;RzNpa=3DWB$nT(R&lt;__BnYcd7(o4N-Elxsq}&amp;%=
x2Q-<br>
zrO9?Voz6&gt;i9-o#2x#;$WMA8Fr=3DC@n$K+vb7X``X;I4ycN%w`^dRgyf#M3sFHmMfB&lt;<=
br>
z8|+*8%NFdkdvllOgO{(qefHybXK&amp;F{NW9v7x6BIg5=3DfxCle|IbzRT!lE-lY6;4smP<br=
>
z!C;Wkz@F%B%6_YzkW0Xavhf@`mkPUqO&amp;m}uh*1O2SJ&amp;Wzr^)+lo(z-O_G%8HXJ7|8<=
br>
z9*h#2K$0%5=3DW~!L$b`ffZtd?IwB0Sd=3De)cC7N&gt;!T%V@H{d&lt;@w#x6%Q@Mo$^23PD^=
C<br>
zC-?^&amp;6##&amp;Di}w)Ib|577mlcH&amp;BZ!R|RG#7&amp;Ub*V#&gt;E2PVH{{V&gt;F9=
^%{2I~S5^`pOV<br>
z!Dqzqg3*papS+K~^a#JgZ4f;2n_!CA-VyYy2x%PmQemMz6T$CIa`8}&lt;Qe}CjvBYCQ<br>
zl`h=3Dwog{1E)Dke_8Lheri399v*RJzfnZE-b^hi~}f{78z5Q7XF^m{apAduKy!CFHb<br>
z4{X&lt;&lt;H%xf&amp;@$#3(`|+~I1fa~tEAh&lt;K-s$ETHxxK2&lt;F&amp;Ru*#s=3DvmR=
Or{b9nIe{r%jD<br>
z3v|pDQvl$uoWp{M-zgF=3DTUS{hGHC-*nWTGhleQPcEm|iod&gt;*Wh__=3DJoFnalIoL;UX<b=
r>
zR-X&amp;2*C+S$dL6J}z&gt;u1`gW2nVEZ&amp;*hNBH@dks&gt;JY(`&amp;`KU?*{GKvWe#F=
P+C*@avPY<br>
zs7Zz6yx4)DIoQxcW&lt;%$MwIjvlixgG&gt;c$40AI0ou~v?jEwsR#i-OJyk_fWmL{1QyXI<br=
>
z=3D?x1-d&gt;(!HzS&gt;maklMp8K@F2?4Fx06l(awO0&amp;8x3Niwnqw$6Bdy&gt;7Xmq@Mv=
!aPCl(<br>
zt^rbIm8l-Qp7ii9Jd&lt;v&lt;=3D$$?|9BfO&gt;8oD?j310QD6V7?IUcvyMvv}Sm14WjDvA2=
nD<br>
zsBojEo_#tVP6nHKRg^XH?q1j;;1}0d&lt;8lplL|}lULF7C{^&gt;BJxo=3D+j5Fle=3Da8v|0=
0<br>
z#QrM7+_BmD$9ztzuc`Ba=3Dm(}pR2_)^2jIn3o&lt;R-U)Oee+Set9#Hw2t`I8z(c0^o@h<br>
zBNC1BoR&amp;`7g1=3D+)4sJaVZW!LFw&amp;m3(xS{VEyemJBm)W}5-;Y+qD2-&gt;u@&amp;=
mZh1_Z0y<br>
z30@=3D8o11G3o*HRVGgt}?XR^KQ6}*Q1{k?9oTx^%u`D_Emu!W}4F~&amp;2nAL^EXRBF!V<br=
>
zitq_KR&gt;{&lt;~V?z8coer;od(F%2J*)jYdhs@EuXZJ@&amp;D#3?(NUn$jc#lshQBKxr#un=
p<br>
zPYjUs13YX)NPdGhe#hE^0@AAsaA3iV-aBNjbi0LmmBDdySP4OA%3JYg`lsv)q&lt;yo2<br>
z9}cEmHux~B@)^7k8HCs4Z$#N4=3DGX&lt;}#SrgK&lt;jEi8$pRz0C-BITeKiyd`i{0bW~z7b<=
br>
ztQl^8&amp;ffMOgC+A0D*lp!!Pf&gt;O2wZH+`nA%WYG8U5lR`k4B57qzr?zRQ5j0FUT!f^w<b=
r>
zMA=3D-KgW;vk1&amp;B*?i&lt;bt^#cPnvYj`Pt@hilxgx-Y*LREMhHV5`47{;uc7x)cJl%5$?=
<br>
zOGB&amp;#qjj^}TfuIj(wg3=3DFaCD9ehKF$dozRg!#l(dy&lt;8YeI7_lTicvya22KZ+&lt;_=
K0a<br>
zd{GIlU+(0lYw^5QpX?u#%M%Phpli?}lyx2(wL#tBr~TvMG0cK)eo*%QO;!_*sXjPW<br>
zp5#gSb9Yi(&gt;vkC|O%^7)aoV=3DN5NPdum0slZS5}($y4lm_^!o7JW=3D~)Wgqx|HRcsHZ<b=
r>
z;IbEx9&gt;rYH34-1YgzFOi&lt;~x|{0K0T&amp;6!r2$NR6cy=3D98bwmJ9`)f|QCO08&amp;=
Oa1*^&amp;G<br>
z#o@s`pguumM@l(v_9}0f0y&lt;31&amp;}77OvcKQ%%@9&amp;_BbXDVtuZ?&gt;W%?p0$-0tj=
qpi`s<br>
zWFD`TX6lzJJdpQKcc-yq@X&lt;1U*I@=3DK_|kEha%$u7p80{;;un96V3peaW;;a)NM^H=3D<b=
r>
zdJ9p*dr*&gt;!!{ZpZ(%Hz!b$pu4%gGitI7eKPwBn{jtCPUt&lt;m{dnREAy0gnK!fAWV_I<br=
>
zgKeRHFkV)S(O_)kCoj%eX&amp;+vug|VOE3|?-$HeRtI#=3DBm+_pa56#=3D9489{lC$R7JZ|<=
br>
zh#|jIn4FO-Z}SS0f!G$@Zl3ab=3DjtyS1d5pF%)N6SI%1uZ-bL&gt;On%}&amp;|pk+_)RSdf?=
<br>
z0-f$m8wJ(%9B(`F4w1z^@lyhWr;QveCld&amp;}pQ&gt;UzOW}kyf5!}uqpNa&lt;7cyX8&lt;=
h~*I<br>
zuGkRg&lt;8*d0xLj6{UkHrBe_~@h^BymZdf0=3DwV_LC}E^e*R_Y=3DIja?U4blU;%O;78fv<b=
r>
zB+c7=3D-f-u1&lt;0;vUB53%VF+v_I0va6~R$qaU8LFxgz%B10Gu_llG1TqKOm(|%GuGX+<br>
z`^|N03YRX;-Tc80l4f$l?y&lt;PW1ixCn^H9qQ=3DeHN%Jap{&gt;TiSHYA2`Q+jpf*cfFP`k<=
br>
zz-K=3DI+g2av#EiO9fAqlAqRB97_qR)U0%p+SrcS|AKNQDMCg~I%DQH0c2M*Bq_mac~<br>
zwl|G_Y|l=3D2hIQuw#eJPfbcQE%k$@kw$-ps~kivKLz!JC&lt;oEIO!r&lt;Nb2J2@$%IAPXR<=
br>
zOMeZkb(GjV$glV5_&gt;?(H;J`Fk!V&gt;)zHay3opd60dA~xhbaZemh&lt;e$U|)9)zGd1si2=
<br>
zn3C5`n9RN)`j#)}^K7+&amp;+YMqf#HYgh%nb@V`~@d_CE&lt;&amp;B*Y@`hH?!r3+ZkYPUJ!=
D2<br>
z+H=3DOWIMnB+pdJK?_N5#m*b(n@u7NO|2Y2&amp;M*MMr*J6C85obn;iapWZe_86Ql&amp;S|e=
k<br>
z$yW~#5W^}C9wry5ptJdpgQh`&lt;F6!}6-{%9&lt;v2VeQ0kLmXHI@r!fPAmEk0`m27|-Ax<br=
>
zeYPlG=3DuFic&amp;j?{^rE*&lt;erB1?LW*f*o&lt;N|R1&gt;&gt;%i44uV&gt;sWppDWu*D=
q)s|p0%k+iT}<br>
zc&lt;oNuSyr&lt;xyiEQ;5*J*{1o~+rcVOn1lof+OO!x-Ezi@D{Q8BS1Xq(+-pb2z4iaDxP<br=
>
z1e6p23h+&amp;DkSnj-B(Ovm&lt;a7&amp;fRg1KP6dtB8Y%dl-GwFg@N@ojn$KcVP(;AW?EI{=
Gc<br>
zXu&gt;_66OpN@lUOM;OxJI&gt;zBqxt2xnVM(6x6HPbn8SaS68)h!~6kUWK+vawN*dj~PsE<br=
>
zbK%;E5HC_*JTZluP6#RT4Ibek$GO?-U;Y9J7wq&lt;T)|R4i``C!F+|xgT?nqSjS%^6I<br>
zuYk8T(AJFf;W9^l6BdC0yU&lt;+xvLhwLy84q4?uz5jZRs7OO`8^LM%hd@jHWBm{0b&lt;N<br=
>
z!#y&gt;B0cTYAJlW)H440%+Q!@J$_m7v?o_1pnof%IUn&amp;}sW(P{nBJD@|KR~JYxfjcWC<b=
r>
zSVFT9?z;#!8mygOJ#EmSpGzB1@b}si5`+z?S7ax4BmJqiQrzfqf}7Y3|G|8!w&amp;`BU<br>
z4^h7zn;D^Y;IsMo9vD3|2Bv`HJ)L9x6k&gt;=3Drg@GTps$+3zpcswsq7Y0-r`shqQ&lt;M#?<=
br>
zH*VjO#dXU0Xc0Ql7Jy@X8jB^*;&gt;)mjh%6UME~2*)&gt;PDEWBHuJI&lt;n~ar^Jr!@L_HO*=
<br>
zI%HB$fF|*XFpovBhXi4u5F|5sEkcMQWC%g;R##XDk+!4c;Q`Mr9)ffj(}|7X-I9=3DM<br>
zB1AxDPN7_5r?xTf!nuOfDaS4_wb}}I_4NzRytg&amp;0K@S#Rt5C=3D(kS@ESVL4;P6ezZg<br=
>
zgrp`)kT9kmR*wE!7d0!D1CKP$YfmGyQqz6hv(GRqZP&lt;I0e%zqEgUv{AsFVhw;9$EL<br>
zXHOy{P-4RgVz&lt;PB&lt;0u2eVuI{Oc94Y@pc6*0DW|8FxC7E))uo6088sefzur!Awh%AZ<br=
>
z=3D6M27dc#hFn&gt;vS~@zwdW{{PMTf4@*eBZr~UZa&gt;AzZUyy5&lt;lAYKaKaa=3DlAR)()=
rA%A<br>
zj0#|4!MH%L$K&gt;0WP!Hw&gt;Yv0l}C?gbp_Ey6(%%d8EhG1#cyneJ%ci1Se^Db8&lt;R0tSO=
<br>
zc&amp;TP5(wixeij}uVr!4aCqEqB+&amp;Jp~}s&gt;P;Tk}uMlQ0yK#SDGoCH^pXwyd4Tc!lH=
&amp;t<br>
zCT~?7F$U6p+H|yJk|Bo!x=3D+nTB&amp;%}ob&amp;9N)0MUD)^4{V9ZWoF#Gjy@fUbl7w_fFs=
)<br>
zZhHVjosvzb!s-!KZ81KJX0j&lt;&lt;3j-UxKhE-ZbV0dWHI{5`C~srxnH@~`I181O7S~o(<br=
>
z24QSqR?|kF+LXe=3D8nCEKqXs7+#j3&lt;sB1&amp;c%X=3D!I@Kh5X~I6xgANfkwMWV$y+p8w=
}Y<br>
zm0@X3T&amp;`6zSY+?V*}9KE&amp;;eXb#3jSj6XlBv?V!ClkEp@M!y2j1IQX#MKARv&amp;4W=
eYW<br>
z7x&lt;KrFDZKQtex(#D7Yt-7AO;_W?tDFlXM1Jp!}9*=3DBn!ApkW&amp;*(L|LU6oQ0NcDlq;=
<br>
zYZrkyyC9m&amp;ohSy#V7x=3D#tw)4LR2$3-i#+T;{`cG89^F3r=3DJxTUo-s`gTw|9$m#v6C<=
br>
z;J6wiMMIc?XKc31)%PHV4B6~3_z7&lt;$Ip|Z^S3&gt;@PMN)Qg8}{wNJN)RIJ&lt;o*s+A(D_=
<br>
zi5`99ZjrgoDiXMJeQ&amp;Ut?v|v08=3D@pQI5S)&lt;w_P{ao+Tx9G71XmpaJc}uW_9m%-GDY=
<br>
zTs(z*fS036W6+NOo;?2dV1}1ZkM{R3`~CE{2p+3^!Hp+2O#c{H2M6gtF2QpzN3eja<br>
z0Ya9S%@vVx#d3TGJVr*F;fv@rc4cYGb{*+7Q^{*{&amp;+gZ0tm#P1#82e5Sxe^2n#&amp;we<=
br>
zYRLP7CLYKgoK3k3yu3&amp;ZfMs0AGffS14&amp;|1&amp;!p|KLj51huLo4y@m`dDF+sX&lt;=
)-O;b1<br>
z&amp;xjJe-^TgULl&gt;l*t8u`3eVgMq3{M1ZoU3JlOk*On(Ch2do*}wLx!dLS#esvyaFBW=3D=
<br>
zLN&amp;&gt;I3U1jHqNkKp3=3D$ts2gKFLbxeP8=3DTqrkYOz2W=3DY&gt;8PFN=3D?4kl67mx=
;7`SdR6ck<br>
zhP^Z|a298&amp;L0{+b(&lt;nVd0!Kxt1puPss~`_jx2nxs^3DWzmXI0MBAY+Q%fHW}bTRh0<b=
r>
zK+bWraHN)UHC-&amp;%&lt;#QeS1)Vv8KV05uCK(ygTj+Q)4Ra7hQzexSX)h!`5%Y+RLh0_Z<b=
r>
z#Y}Zl%d{E#&lt;J@jJc%m3#w%g|?WIg7Dtmn^O{GXRUy!rmGZ8=3D+XLdN43PC+RQYROqC<br>
zVL~HGtFG77vVnA8#7j&lt;YAEXsB^cby&gt;A%Zu1*+@4d?TZ++96_T&lt;US0MJP|}*dK1O6d=
<br>
z-XIerFrD~;PKs!xO&lt;e#R51Ubhp07E*7UwKsZ~=3DKBG5Ic{&amp;W(Fa0fAa1SS&lt;R3^e=
Q)b<br>
zwgNEZ3R%&lt;D-`$m?0eAR`&lt;Q$!qBEF}KRs~icj1svG_0^mNJUN0mzXH_GHy#KnF*D^f<br=
>
zKu%_C4j&lt;rV;SrNPINa@e)iNj7N%UsT$K%6peh{*oplP&amp;G8-=3D;=3DbfSiY;fV-IGHL=
U+<br>
zl8xxV=3D2a6pd4wp5dnUdXWFd)iOP02KhVyoa*PbmgJ&gt;Ec4C*4EF*WN(9wP!dt0Xa|S<br>
zDlV@#+n3Cqu$f&gt;DzDqqT!9NKwgO5-ZNE(9d%*$^nT^a6qT4*hlz%IDm2wx(L+wbi?<br>
zhcttk7-=3D|#*lr*#ZHGg-J&gt;&gt;u?;|^9fM(dz8k|zv}NWT4STX0^DdU!%Gyf$WR?&gt;6=
b8<br>
zv&lt;?lr-H8lrWWq23Vl00LfqJP1y&lt;&amp;nR+iXZw!S2*26gggLyQQD#KMlgur#orPMmI9=
1<br>
zDSU#CcOB0YUSKe*6HHsWU+t`H(&amp;RILB&amp;9`}O?xO}2j)0V#Us%1zDOv9wBa#@EOS#Z<=
br>
zc5Vf;xyBB;sXKlJp=3DD#ihh&amp;MwmXfMq0zL13NcIr&amp;jKwqNxl0UZ!%d?LC(YyavS&l=
t;ib<br>
z8X~AFAEuE&amp;IptLK#+G#xQ+XRW*1CQ&amp;$}~?}Um?=3Dk&lt;|tCzNzQm-ObI*RSKCh!c=
DvSh<br>
z8YhlOV^8jG?t(N3JI&gt;1=3DS5Ssc%ngJ7L&gt;%=3D2YLlTwGTMdnA@(Z~@0ubZAQ4I0CZIA=
A<br>
z9C4V4nRZ`=3De}-q!7@o1*pwp3H_gE9(4AlsXWYp=3Df25;9;3=3DfIJShd9nt1%TeT#;;-<br=
>
zP1zJ!yVm)dHuAvkvo;+QqkH6N2eLlW(qhbLuoie95w{*D33(&gt;Ct&gt;e&amp;qWr%GrlF&g=
t;;R<br>
zHVX#8d*DX#llFY!UU!vjjlHUqAaR&gt;c-HR5WFl*W_%vE;qZ-&lt;`_K6Qn-srYcjOkvS{<br=
>
zN=3DZ3Gim5sF!dxi7UQ&gt;F#WTrxh!Ipy~C#Ul~@K?KYCbqViKags|Y|*rFL2Tl@)Emko<br>
zj;8DS)flL2Gx5{9Mzc3IpW8&amp;=3DY!d&lt;S+O(7LPG#d$rV9=3DvBZ9?85`j&amp;UND`x=
yLkmkk<br>
za`R}&amp;W!Aa^=3DPzV}62^0d0SJV&amp;6TA{0n&gt;KV5pcvscaK8q#c1TQrB_yT&gt;37u=
jjQ*e6I<br>
zG0FyCh?Urw-os~MN6#W1qaq9u^;jb6PfeuOPcp&amp;ZTmf~ZRgJ^us4H-@f&lt;qax&gt;F&l=
t;#0<br>
zJ(Nu)55nus8yuvXpaKk@A$lT+C2uri9()C-jJWp?lzk*ptEKneuI^2q8nf#V2=3DR6|<br>
zre2&gt;*lGF!}Ey{3cfv=3D=3Dc!acbt#aTh@ZVw!V9*=3D$f8iVvJIdMNgp!)d|#e@JTI5Gh1=
<br>
zA8=3D&gt;}c14Cb9^4|cZU2wib~eby8ythAjQZXkucZMf{|b7f8^&gt;;wCz*)B82-Y1uF7n4<=
br>
zy)FZJ79&amp;+?GB+0u6KzxC)RJ&amp;SF{KH%iEeD4S3ptHqxASlZT-5p#~?D`d2?MHL=3DHV=
-<br>
z;0REna=3DeLJN~gTy=3D8Mxz;`H&amp;#8=3D`pEBJUZTAJ&lt;k&gt;8@mqPCJ5c?YlV$CUIX=
5hQ~eG)<br>
zBd30YzFQ0YpS*Vp9Cc){NW&gt;u=3DW|3ry1=3D;p}8jf&amp;`(Zcco{VItqD6ge+U&gt;GGG=
M+xIB<br>
zgvABUKP^?9FCyo+2K(i~{hn_b?cO8ZG8_lC+v52Ac-MJuS|-eXl!A~@t1ImSB}8vU<br>
z5p%elDCF_U)N%?y`p~Gn9&lt;?XL(Uzbzk&gt;!;WRJY}D@9--P7nSg&gt;ly^Arpw3|}J%MyG=
<br>
z3GHMQv~DJdqXUZ~a&amp;ZKjcBsK*I~--&amp;v#y!?v+pECDW+-h8Ja;5*I^}u6&lt;Nv=3Du=
_Sj&lt;<br>
zLclEl&gt;1B&gt;wT#WaO!9-&lt;_w#(&amp;wTdm+=3D-c&gt;e*(x?v$oEu*+KgRjf6s(VGs=
@Pz7Mc{A$<br>
zbjCEP^2F0~Ps^NW!(_xK{{7iz^S1jt&lt;$?&gt;C1kUfRRL%&lt;S@S$5S+Y;O~8zZ&lt;?E$=
WS`<br>
z1=3DWOetD&lt;&gt;*zWcfETh12M6$c#2xy&lt;J)$OuB2GYZS&amp;XguW9ay=3Dv`OnHUJK&=
lt;|f7z_mKe<br>
zu|{qd9XMgZylhfWTiWz96w3RMJbiMA{;dsIthxr=3D&gt;|v_bmYz~ZNQ(+0q}ytXdR`D2<br>
z1rCIL93G`q1BRxl85||g`F&amp;M&gt;pqggG8@CeFk}Ezson&amp;}aJ1k7F^;&lt;rs+Clz=
=3Dm~E^1<br>
zpBWFvBDLJkQL2pGGQ41%fd=3DqKitSLqR=3DBZEFSZcuE@j;inSX2L0=3Dbi!W7euCT37wH<br=
>
zPs59+r_TOHbAyk%SnAJp#)gYGY-|y@8H?!$?+bp2!4m4ANH^GKi=3D0XtcroaUKv`&lt;J<br>
zz0zjVELZq9d-S)CH11r%*V`GRfFjk8n^Y+0_+eHqkp79XfZ4qIJJc=3DMkd9^#k`Brk<br>
zQmseT&lt;7_@1DebU_taB^pr&gt;X2VE5$-9!H9Eb;7pd8elqFzPecbqB&gt;sGIL0X~9Lz-eG=
<br>
zFaQlf0%J9pT7)qu=3Dp=3DOKj8|C#SAgP{kRWDcC0E(v8o|lE5z&lt;VEW#M$DRX9NQ8T%qZ<b=
r>
z(WrPZG~Xyi&lt;Qr|c{D8GVk-wy72q5+`J4gm!IA?ydPC3Rzf&lt;yJ?1M)O=3Dz&amp;lZrZI=
29U<br>
zLJ@z}+fa^7J}YkOgY?F+76qZ_cVroesWPd4IU`;JV=3Dgk_K+l@jvhn=3DF#g~2buF&gt;m_<b=
r>
zmfUjE+#g3GMXom2;5E)0Wag|Y6&gt;zMNQ6mp*5Xo&lt;iA|mz#b_KT?-H=3Dv+v^~B`$&lt;J=
UH<br>
zi1dsb(|w7zQGLb6w9V$BiebXQqPa$Tr|ku$*m2aI@!9Tr&lt;s&gt;6+o1bSFdn05SqQYr*<br=
>
zF``I!eO`=3DJ9_;Gz!T~XmzGF804u}J*Hix1tRHi2K)AYPv7a+Dvb(C~UQX1-m)dv#X<br>
zW(Y*^qN-w_`BvmzVWHs)G`&lt;Q*Af-^$fOAK~C&lt;Mm|j;HFpwlW?U2#-&lt;@BGe~D)x67t=
<br>
zA{{WY@Q0FSy!Ii^uJF!?&gt;j)0Jd@9~be$s$k{FBD^y}2#!C`}o*)oyUkg1yL8A=3DqO!<br>
zxT6Im$~7iP8nOiY2sxt{@qHYwwFWgBtv0U(YG+6v^XSsMF(#h@+Oo9@UMk&lt;pTW#RZ<br>
ztaR(%kzzE7xG+S{49O4v&amp;&amp;Nef&gt;Hk|iBsuX3M8si&gt;J&lt;5g+wgCj8IXIt(Ui=
60gwi8Cg<br>
zctC9IGx1BN9O5tyC;rwZg3*0OFyCNTc7!p+Mpi_`Sq#C5FeNjk3k!^KPSs0uj2fG_<br>
zaKl)veM-4hC09z;I?aMT!XMz7dTDt+rr*30H&amp;iTu(VVmI+QYE7w|j-Tj7h5yeF#bq<br>
zPnDSq&gt;|(wE*ZcAHOQ9Q5iPZxH`gSX%Gyk0WT;YTP&amp;P;Q^2e!f&gt;D;gFZ&gt;SmA2V=
hknS<br>
z8rohvTZPh~e2%Lo6{zlGyo4O@Qb&gt;zmW@9)LC)S(Y?LcwndKA%231p%cG=3D_spb@&lt;&lt=
;#<br>
z)9iY?JjLI`Dy2L|E^LM*$4l_=3D*=3DXkc3&gt;6iV1ve%u3z{U@rk1#6pC#_Xq9HdR{vcY2<b=
r>
z$$cCq&lt;M|R*caa3(Rz7PNU!olejBTEZG3ELckc$E;jTTa7%%=3D!P5U6jRAt%^2^^n}C<br>
z2;pg4-Z@11ekmopq0G#=3D;791WO0U9O&gt;W&amp;7%TncF|kTJPzjwJJQ_RtCR-|-SfSFeBp=
<br>
zIGg_t9!I)5xO%$OpX9q)LDi*ywGDpuubwR7cvziUcPnb5P1wtMFvlo-pw?ABp?$Jp<br>
z=3Dy!jPap=3DdX7DXA(u)|?=3DV-f8k`x#blT`#hE&amp;c(osH(WuZJ4@fC^YqFN6HyK7@2Nm=
B<br>
z+3DRCvaHz&amp;__G&amp;50&lt;Da4f~l|&lt;yAP0R?a0mT8A(-6lt7$Kitizh(f1K2L?R3m=
rJBgx<br>
zL5VUP&lt;M?#A1&lt;WDPJG9uaI;I*~3qS9SuC!#v^@cw~50B+97v**U@lb&amp;6E`X49HPMI=
2<br>
z%fxIlC{BU`IR2KNJ)Dl5)4Le3ulouWXQ~CNDG&lt;TJ%Z;-=3DJDM;)aGR3~KHWccr(p0X<br>
z08M$wd_AM&lt;8C}yUtkuD2iXYVL00?fbTq^3T2td=3DreX|U%H!y2`DRWAd;3?t^`D(~v<br>
z1XRJpNirlqELR{i3&gt;@F4JLKQGgX0L5OgL*w&amp;%d+g$M{r*P+?Cp7+M2RCrU#&amp;cXP=
Q%<br>
z&lt;+Gs|&lt;E^BcVqug1r68xL|39loM&amp;j*d0rLWdGxBttf?@Vf-U;CtIOG!c35_;-M}K&=
amp;7<br>
z^U)!G-U?w`YJLywV}APRYw6T452_(upkaS&lt;aG5UfFbUk`pntiNEl=3DQ*m1~y=3Dt4`r(<b=
r>
z&lt;hJTwp-3=3DJ&lt;Ss7Kc}&gt;d&lt;n|btuSI(7KV8&lt;5~+CuCCb+s5l)Wi0&gt;qp!Q=
i{p@huJ4pTw<br>
zsYu!clg9kGAxVlD&lt;Go&lt;@uQQrwW+&gt;8G3;04hs{u&lt;ceLDS^04D5SMP)~53pjhty-=
X00<br>
zCk^K=3Dsira}39Q4pOCSp6MED{+oHfAO^K#XZedy41I~og$XH3eIpDR&gt;k6VfPFFDn0D<br>
z#I3lZii$+AB;#Dfg6y}&gt;=3D9xcG6{-$Fsz2VXNgAHZX+$&gt;CYvd%%-~oUqdER=3Dih2~C=
9<br>
z_(-Uk7UyPTJQXU-9%{wxKJ(IvMFA5WVA~eF4l8Kg!$t8Sht{*^I}*GAbx{xM%$^V-<br>
z-a7Mt`0a~O%&gt;Zx$b|Y#WduCa=3D(Gy{NriWPz4!~GMt*`CD6F&gt;DFAgT`!Y6)*O&gt;BO=
tp<br>
z;pD&gt;;0G&gt;ADMdQ9HD!wbwc059L2hlfFcV%`2#{;ow)HQtm=3DH-7u7odYHQwrxn-sC%j<=
br>
zzZ5SR0q&lt;Fz0PCcLYGd+uX_?;e1DqR`2r-G@$u^zw&gt;3G}~s_RoR_!SQR@k}No^=3D!WV<=
br>
z^Z!z%AJ$FiQ)oPg7GIpQ&gt;@bz{Za6umxq&lt;I0M&lt;i)?BO%FQacWjYBaJ{&gt;oPjgnx;=
7H-<br>
z&lt;s5B1z&gt;uyHdDI|fPIZ|+O^lZf4AqtT2XX`bhBQ6%FvUQdL6A&amp;q3=3D`W~*Q)%sGN=
blK<br>
zLrnRjDv1mg5kB}Fh*Tw@J-{mH4@%nbR1Y8Z^TS7XrcZ|b`i02f9UW*Cpi9^TgUXvQ<br>
zYH|1|?B37shAmTSHnfS=3DG$nwcRs6QVLO5fL6`blI$nTVGC8ko5FOnnHNUd8FFLv9a<br>
z|CBZ04M`(A%{8#bY^WYG9o!PoROX`!&lt;&amp;Btqyi5H_AID@E*MM2FasJjpaWZ=3D{C2HXh=
<br>
zD6B^OyFVLNPx;pYK9RwDOr%K7q=3DCELuOzdH-*}1PX(IgzDi-SQP7d;uOT2;Z;}!G=3D<br>
zLvX9h;XAy9=3Dg*@D&amp;oDk?QU6^}PbhW}G7ddV#-;o|DGRRG=3Dr&gt;2Kg4z)XCMcY;mGd=
HA<br>
znwUHWGOE!`{yw&lt;9PxY^u#l+^w+s2QYL&lt;TQ_pChO6cCv%fKmO4@E`R^EXr@SeT3*2i<br=
>
zbb&lt;oFaH=3D~tfi)_&gt;dj9b&gt;&lt;s&gt;*CY!(9p;@Q6=3DD7{H?8=3Dw{Zq(&amp;;=
w4ecy^3B?=3D&amp;i32id<br>
zh25bKwDcOmCT&gt;BXK+NcG);Eqj!KB_)h(95&amp;RsMp4kMob6;||cKKS!Z}c}E2V#gsyk<b=
r>
zL-UMR#M)uFrl`3*l?n526+jpU8f8tN;|6tgQQS)53wSgi%#5c4e**=3Dtcek(kKP3&amp;~<br=
>
zl}5Y`k?aVSdrSDv_=3DWWYOU{EzUFgd?sA%w+E_C&gt;&amp;fz3IG`T2#kNBXgu{~?b(j5zvW=
<br>
zh5Cyr^M;P8)oy^CYfezm70h=3DWz|M)D#IA&lt;_pJ}V&lt;w?}Jhf)&gt;^&gt;2BYReg!@LU=
QPZX)<br>
zXDfrox%2so-J8MY1?kSv0bnvD2e2o}xu=3DTvODlNj9zaDCB9y&lt;*r=3D|DBn}BD6(VQ%S<b=
r>
zE93C)vC&lt;7+!$@VxLOxF%&amp;sDQUQj_$;l9TkZEj`H|-JhUjV`_@hzbxHlwOnxt_J2yc<b=
r>
ziwy?d^PiLMBKan6Sjjhm1+*7#N`r$Y-^-%&gt;7Z7b9F7ZK&amp;Pk%%xRO!N(guCl2F5Woj<b=
r>
zt$FNx(g@Qd0tn)2r-Tt&gt;=3D5Zd2t?pBKEW%wae`WUAa$vNtS~7S(dmN&gt;=3D*mIpkEx`r=
R<br>
z%|O^kCcw_6yAVXwm%;+Z?Qrxr7?n(rUlFbTwT=3DeUL-5uY7US^F2Lp#1exK=3DlP)TQ&lt;<b=
r>
z4VFO-K{&amp;(Bi%wNuTfG`;l6o!2IXc8C?mZqz;%W1EK)yHK9k8$96vS?ccg5zY3mlLu<br>
zg}&amp;Cdy8&amp;Db_56Y_F&lt;w&lt;A2*Dl82LGg8JUFk4X_R#hGSnX(=3D-U-XMA&amp;7=
|Pu(w39y3-R<br>
z-OZZ%C{iJiKwqu}nf4Qk4BZP68G2zNLoY+7V&amp;$vs(fuOB#{6|6gVW1c0CQsRt~2^#<br>
z)2M=3DsMwDX)jl!$XWM%hG#kL&gt;T^Up$VI`(YS($FkzW+ck9Q&lt;%BLI;Ca9HQAv;G$``X<=
br>
zc}n#&gt;c*5cu*o@9E&lt;XTSJ`D-bGF2`X+xN|pI%73t-Whea~MC;=3DODY-*_H~F&lt;$As!=
f=3D<br>
zqy`Vn@og)9xgDlPtyvu0!lxo-O4&lt;aZWq2i}sY29hD*~}2Db&gt;%URZhbPp4UG2&lt;9nzu=
<br>
z9y5&amp;FtM#HkeJU2S?cI$VrHlN=3Djcx?=3D!()7&amp;g}ypz6^%gUZ`t@&amp;=3D-Q&am=
p;8i-#+Yp$(#p<br>
z4vE~}vY~dB{i3!Mp;o&lt;7&gt;g+cAp|}|h1qu(Rr&lt;+sfK&lt;--_&gt;W-(c{vAo~*?lM=
`;MLVK<br>
zcGW-tM4$}HpSbX~u17lQe2FEo#gMEtFiEc$f{YsK!p?Bc+&gt;lLD@tNlfW&lt;ztOWZB-}<br=
>
zDqGc0$s@Ik-%q*e$h~6aSty2FrDmVIZ1uyxd^HGi$f&lt;OiS&amp;{sWQZZY}O&lt;vFCK0lu=
@<br>
z5|IPrph(M$i`!e$wGlVoAQRTli_|#73u4WEGVbY!dF^Ag&lt;^&lt;dfR@WdcS}H+}Vpq%|<br=
>
z!u!V;guKzND-G6n9dEx6%yIEW!G%Dx2vHsTth;91OPU|#{kFXnHxD{lk|#$4H!itB<br>
z)@5F)kde95jUnoxzLNU5JpUO#MdF%L-E?n+&amp;lgV4C+cnJ15Db1$3}J?9p!*VjZ;+P<br>
zCscaQy7KJ92?U&amp;!O*)(*qGTot_6km%WR#1FS5A;ThvA+gA(ejUSE+GS5!VODzzTX3<br>
z{c6mGde(N)=3DIOT)$n%&gt;H{@0wLCPdrx$OzR0L6bBGR_u)dO?5WMTp3*JZ3fMxdbmEP<br>
z?-8@)lbR7Y#4xWY2;hpH37}wHpjxBU`%YX*C#fT32f+c40%t_rr|RaFYuGv&gt;1xYQ$<br>
zlNc~!=3D~ROlFW-ZUPRBE-Y;pM5Cr@$n&lt;6&gt;J$!Bm&amp;iB!rbF?khoY=3D*^ZH*~Ws9=
5R;&lt;n<br>
zxJ%P$+&gt;J=3Dx(J%A*hxaQyuC0CQq2&lt;d05oDO#N%g8gBDtFJm@&gt;Yg$8yUTRt*{w{y6=
Sw<br>
zwKK=3DyG0a49LYDsfmz_(=3D#z3#y@e&lt;sNY;6dLW+5jM?x^HMlNE|^O9Uk`W&lt;Y#UN(WH=
&lt;<br>
z%g=3DLoC4h1|LbMa`g)aaPg%VERn5J)0U(dC0o0hO-I_bfjp${&gt;{a*8+&lt;szHKsYVr!C<=
br>
zM2Cpl4pDt=3D-{+v3(MFU^wmvh}@L9at6fsjnN*)YxHf{^Glawx(TW3+(Edd{5Ec_~v<br>
z2r{s5*P4JrIN8&gt;k*sXjz$X6po`FDsnxa+6z(CrTCa;?VJSg%GUaOlj^cIbPx#OMRi<br>
z6Bv*qAiAnC6{P#j3{Y6Ho&amp;7-Bc{iaO^1~tB*9EqDS*&lt;YetI$p^&lt;)@{OKmrI_iyPV=
0<br>
zJX+xkQ&gt;a_)qxci3n6*!l+otMXKJ7RL%NPbj;vVis-|aFFx5*1W0D)6R*mSDFEJ2N0<br>
znPT}&amp;a8oGAM80Sw&lt;i^ZSk%bNwS@emY_-jVMekXFs^2ed~m_bXhp46cGq)&gt;zn4nnO=
W<br>
z=3DvTu7tDrNEU_HbO5bgC_Vw*%CzoGbhTNVO7ePh~Y^BeNW5=3DE6tAy@3EEL_|7P=3DM8X<br=
>
z&amp;USumo~i&amp;}alYHxIzvE(YG1y&gt;&amp;hN-v0H&amp;oiOrtG`L?O^aUBnpz_T-m=
=3D&gt;o^-nf=3D^Gb<br>
z((U_29$J~OW8Xp$9HBzT&amp;1#&lt;5R;q$-D!)`Or&gt;r?=3Dv7&lt;r`K3~P&amp;No7od=
m~2JT#)p4s<br>
z?!=3D%)wAT8ps`;GG$RbzoUnLu}335f4OSgV0w&lt;a~EbtE_2&amp;0++Ac1lhP+p}m&gt;wL=
kKn<br>
z`ZG9aCQSB$XjW&gt;A)$}dd6469xPk4p_gd^_*7YeXowfZ39E&amp;crNKULcqCmVgYT&amp;{=
F1<br>
zoo}cU$SoeW467$zFIH7pXAxJ6Qj&lt;qRbAdjlZZifmX!XGV@apZWvr)n?&gt;F~dl@u&lt;Hf=
<br>
z;e@jBU%vYG*^l3yy&gt;+e#6y#%Fekd-ehWAm9usUhxaxRD?*+*k!gwW77gUphQd^(C1<br>
zr_?@X(2&lt;5h#x7fAnwrS?p-?lks(b&gt;Ajh|BwpYqYxR&gt;wQt&gt;y~1XGQ6MQNH`z^+s=
S$l<br>
zsloKgDC-x&amp;UFH`v-UclMqf&lt;eG!tAuf7o9N*GAqF#hhsDG-4e&lt;tBjgLBMZy^`d@8C=
s<br>
zxO_@4@o#QG`}+_B9MJta)(}GsB)s(Sfw*8C=3D)&gt;f{e86}TnO;Ktyj%%6A{fXh5pAd$<br>
z{fgIaLv7`aSwPjq^82+UfQb4c^6@$fJ~r$R7~My^=3D`qZ=3DFklkBAsiI=3D!jp7&gt;i5)Pa=
<br>
z!`7E+_}T8I0273D2{b?^vSxKbd3A2MP-wV;{7v+L?^jb-D6_)2ugklmqjWf|3Wr46<br>
zlIQ`!kIXZkK)f&lt;CV+?tGUI^v*`gzuSD7rI*$QOqaNM#r4&amp;B$h(u!n=3D6C&lt;*M1X1=
yE1<br>
zb-vAnrH&amp;B?UQWIy3ZVQx9v){`d4S}gJ3CGKC?bupUJo&gt;6&gt;OP$+HU5o0jU6+^{t}(=
w<br>
zKigfNJe;gnYaR%&lt;HKNDS069m3#fDUeGETIxn2SeBVv~j{pR`&amp;zTS}Lj%3u04O|-bX<b=
r>
zU?O$MiOSmLB(7&lt;H+@FwU&amp;k)pbIzv%3CH`r;5?{1wOY-1;eMv_1bv{HWh&lt;x4s;X!r=
;<br>
zaMzuF07?X*O(E-4KT1H(9$6`HSbp5z;!LXGmEC&amp;IM?lEyqivMVTpwxBt93hDQcjWU<br>
X12l9U@Q92=3D*7GQe1K@g9&gt;*W6dNOSnh<br>
<br>
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toast=
ergui/templates/base.html<br>
index 709573dd..e8600f3e 100644<br>
--- a/lib/toaster/toastergui/templates/base.html<br>
+++ b/lib/toaster/toastergui/templates/base.html<br>
@@ -18,7 +18,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;script src=3D&quot;{% static &#39;js/jquery.cookie.=
js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
-=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/bootstrap.min.js&#3=
9; %}&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/bootstrap-3.4.1.min=
.js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;script src=3D&quot;{% static &#39;js/typeahead.jque=
ry.js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
diff --git a/lib/toaster/toastergui/templates/base_specific.html b/lib/toas=
ter/toastergui/templates/base_specific.html<br>
index e377cadd..425f7ed7 100644<br>
--- a/lib/toaster/toastergui/templates/base_specific.html<br>
+++ b/lib/toaster/toastergui/templates/base_specific.html<br>
@@ -14,11 +14,11 @@<br>
<br>
=C2=A0 =C2=A0 =C2=A0&lt;meta name=3D&quot;viewport&quot; content=3D&quot;wi=
dth=3Ddevice-width, initial-scale=3D1.0&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;meta http-equiv=3D&quot;Content-Type&quot; content=
=3D&quot;text/html;charset=3DUTF-8&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/jquery-2.0.3.min.js=
&#39; %}&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/jquery-3.7.1.min.js=
&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;script src=3D&quot;{% static &#39;js/jquery.cookie.=
js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
-=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/bootstrap.min.js&#3=
9; %}&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;script src=3D&quot;{% static &#39;js/bootstrap-3.4.1.min=
.js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;script src=3D&quot;{% static &#39;js/typeahead.jque=
ry.js&#39; %}&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/script&gt;<br>
diff --git a/lib/toaster/toastergui/templates/js-unit-tests.html b/lib/toas=
ter/toastergui/templates/js-unit-tests.html<br>
index ca248962..41553c4f 100644<br>
--- a/lib/toaster/toastergui/templates/js-unit-tests.html<br>
+++ b/lib/toaster/toastergui/templates/js-unit-tests.html<br>
@@ -11,7 +11,7 @@<br>
=C2=A0&lt;script src=3D&quot;{% static &#39;js/layerDepsModal.js&#39; %}&qu=
ot;&gt;&lt;/script&gt;<br>
=C2=A0&lt;script src=3D&quot;{% static &#39;js/projectpage.js&#39; %}&quot;=
&gt;&lt;/script&gt;<br>
<br>
-&lt;script src=3D&quot;{% static &#39;js/bootstrap.min.js&#39; %}&quot;&gt=
;&lt;/script&gt;<br>
+&lt;script src=3D&quot;{% static &#39;js/bootstrap-3.4.1.min.js&#39; %}&qu=
ot;&gt;&lt;/script&gt;<br>
=C2=A0&lt;script src=3D&quot;{% static &#39;js/filtersnippet.js&#39; %}&quo=
t;&gt;&lt;/script&gt;<br>
=C2=A0&lt;script src=3D&quot;{% static &#39;js/importlayer.js&#39; %}&quot;=
&gt;&lt;/script&gt;<br>
=C2=A0&lt;script src=3D&quot;{% static &#39;js/highlight.pack.js&#39; %}&qu=
ot;&gt;&lt;/script&gt;<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15244): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15244" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15244</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101998960/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/101998960/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000002879640607dc2d7e--

