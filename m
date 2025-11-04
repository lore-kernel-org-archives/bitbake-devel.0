Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F85CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 09:12:11 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13715.1762247530146437310
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 01:12:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ia8mfTIL;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-81efcad9c90so62227386d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 01:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247529; x=1762852329; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7t1Go3elg3VbGRKdAFSyNFnqZdygYSx+q9Y5qGeWRb0=;
        b=Ia8mfTIL6IF4rI5z1wuJU3rBtRxn54KJqlhErYab8s/hdqBYRUHGQeWA3+qFfHtubq
         klppQ1y76ue25I2greWlcOYpqFbrtFhQoWtW+nCPLBGFghQ+heWl+joEL1leNP3C2pxk
         J/zcYJ19rfaVEHqJ0ReW3yvdm5morwZ0uZesFHvUvC5Er6L1HvbT3hqlsXrVPvyHLi5q
         jPcNbayMxKa0a5WhFRS17CJuPCZQdgyapTJyIUhN0uLfigeO385Rw0T5K3ctdjRauCtl
         ez/uhJ3vPGVXi1Md1FfGRWlmrZwTJHDgWL6BzihJNu+4jL4ExnuXEM7hvWiAS2px9kuG
         DQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247529; x=1762852329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t1Go3elg3VbGRKdAFSyNFnqZdygYSx+q9Y5qGeWRb0=;
        b=asE6IxjKsgye7+QRDb7K1wJ4Sn3So1WcCiB1kxbMjOM9xNtRcTN0gAL+goi0S5Olih
         ciErH7zGFLVo+RhQWfXsDObObW6CCwqmsKg0MDLQiz0I7LjsM1Cvrxgjyq0/5U+A2mqy
         s4Jn3A1EUwEUx/x+G3vIHhJhpQek5Gi+2iNNvLpn259sPAQROQhqkOzAWo7JdNoAxUz/
         Z12AWMMUXVkMs+bYswX2bF7Jf5Ovl9CXUNRWUtNFcYiuBRokJ3pIES34uQ9kIr/qVfdj
         CKM5OHMOWefzDdZjDcrUPaoEU06wG/m5oszw03bz9zVKZCgFbUyWsWCH0cyDwXnTR5Kt
         gAvA==
X-Gm-Message-State: AOJu0YxsQFmyuStyoUbFh9EffUzijHj2pXR4Oldzf7Q9uPx6tYsshwwK
	7F0tG7Uc7JOJWppOPzXOpF9fY3GrsIIDj7E7JDe9vCvOhB9ujNOWRnelbMki7pPz0y4d/o2D92V
	t1SluffRvmAoUrUmafKkz8up0OJSeJVw=
X-Gm-Gg: ASbGncu40F89lf4UXjuEWpiFK5DcjUo2q65G9I31TosqqjsG0hRdczibRIhePsox+mF
	yIvIn8zRBwhN48Z07p3uQL5BIzySy0dZedXLXxQ+K1Fm7/BDmAZjlV/1cp69K6yfFtkExu8AB8M
	AMYSAiKV8agyWHUjQ+NJz+bYqtC+ZdsbuGuw9G7xsFXDNXbP6iua2hMqPpVLC0G0fXIfHqIwl85
	67y408m45bz6oZ13j+6ZLnugRqcXFzgHio/v47Oq1CHk1M6rLSOk3Q8c6NSvfJ9wWFOH4agg9nH
	+xhcjzfb1XvXPZZZMoM=
X-Google-Smtp-Source: AGHT+IHD/gSgGGFd8DylabQ7cC1+FU6VRBF4hCgiKq4bvstVRBWRzvoMKliTJ6wS0TR1WsQYgdEDGKvRhk05K4pwOks=
X-Received: by 2002:ad4:5f07:0:b0:880:4d78:a2a1 with SMTP id
 6a1803df08f44-8804d78a4b1mr113387356d6.40.1762247529063; Tue, 04 Nov 2025
 01:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20251103214804.2004903-1-yoann.congal@smile.fr>
In-Reply-To: <20251103214804.2004903-1-yoann.congal@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Nov 2025 10:11:57 +0100
X-Gm-Features: AWmQ_bl2mfr8TBecoUu1JwZHfcpd8NSkoYCPrZRH4h6tRBjhjBF8W_zcl1H082U
Message-ID: <CANNYZj-my6JU4isux1GuCGZfExhbpD_zXO-nHhbDn_pe73Yddg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: make "path" optional
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 09:12:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18246

Thanks, lgtm.

Alex

On Mon, 3 Nov 2025 at 22:48, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:
>
> From: Yoann Congal <yoann.congal@smile.fr>
>
> Layer names and path are often redundant. Allow users to omit the path
> key when it is equal to the layer name by using the layer name as a
> default value for its path.
>
> For example, from poky-master.conf.json:
>   "bitbake": {
>     ...
>     "path": "bitbake"
>   },
>   "openembedded-core": {
>     ...
>     "path": "openembedded-core"
>   },
>   "meta-yocto": {
>     ...
>     "path": "meta-yocto"
>   },
>   "yocto-docs": {
>     ...
>     "path": "yocto-docs"
>   }
>
> Remove redundant "path" keys from default-registry and tests.
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> Note: Now that all "path" keys are removed (because they were all redundant),
> we need to ensure the "path" code path is tested by adding a test for
> it.
> ---
>  bin/bitbake-setup                                    |  2 +-
>  .../configurations/oe-nodistro.conf.json             |  9 +++------
>  .../configurations/poky-master.conf.json             | 12 ++++--------
>  lib/bb/tests/setup.py                                |  3 +--
>  4 files changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index a0426005f..57375e450 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -81,7 +81,7 @@ def checkout_layers(layers, layerdir, d):
>      print("Fetching layer/tool repositories into {}".format(layerdir))
>      for r_name in layers:
>          r_data = layers[r_name]
> -        repodir = r_data["path"]
> +        repodir = r_data.get("path", r_name)
>          repodirs.append(repodir)
>
>          r_remote = r_data['git-remote']
> diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
> index 7619738b1..9cd11a218 100644
> --- a/default-registry/configurations/oe-nodistro.conf.json
> +++ b/default-registry/configurations/oe-nodistro.conf.json
> @@ -10,8 +10,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "bitbake"
> +            }
>          },
>          "openembedded-core": {
>              "git-remote": {
> @@ -22,8 +21,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "openembedded-core"
> +            }
>          },
>          "yocto-docs": {
>              "git-remote": {
> @@ -34,8 +32,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "yocto-docs"
> +            }
>          }
>      },
>      "bitbake-setup": {
> diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
> index 60531ba02..9b63ea5f0 100644
> --- a/default-registry/configurations/poky-master.conf.json
> +++ b/default-registry/configurations/poky-master.conf.json
> @@ -10,8 +10,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "bitbake"
> +            }
>          },
>          "openembedded-core": {
>              "git-remote": {
> @@ -22,8 +21,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "openembedded-core"
> +            }
>          },
>          "meta-yocto": {
>              "git-remote": {
> @@ -34,8 +32,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "meta-yocto"
> +            }
>          },
>          "yocto-docs": {
>              "git-remote": {
> @@ -46,8 +43,7 @@
>                  },
>                  "branch": "master",
>                  "rev": "master"
> -            },
> -            "path": "yocto-docs"
> +            }
>          }
>      },
>      "bitbake-setup": {
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index e320cdf56..85fc24f88 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -100,8 +100,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                  },
>                  "branch": "%s",
>                  "rev": "%s"
> -            },
> -            "path": "test-repo"
> +            }
>          }
>      },
>      "description": "Test configuration",
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18245): https://lists.openembedded.org/g/bitbake-devel/message/18245
> Mute This Topic: https://lists.openembedded.org/mt/116107021/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

