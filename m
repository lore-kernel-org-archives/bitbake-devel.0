Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
 by mx.groups.io with SMTP id smtpd.web12.4508.1607554292251739765
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 14:51:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oRGFgmf1;
 spf=pass (domain: linaro.org, ip: 209.85.219.195, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-yb1-f195.google.com with SMTP id v67so2897130ybi.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 14:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nj6AGUIJ7Jw7C42GYP493nnjCycIg/FsZyXH/brwYqM=;
        b=oRGFgmf1luTk19XP3onlG3nDdnormuX9zDeLGdP5kJniskwbbu11DZsv3PQ60mnRU8
         fxmdF1EHTg9Ow4/UDif2vNV7waUJluKnTzs85RY6Rfv9imk0M4l/LXZDHOhFT0CfdU6x
         9/qHeNjWpu8qIdY/2KyfVFmI5LzFkttiOZiUEoAPo/At+YBCCRC9HruaiLLOPU9aq65B
         rrDLxTbzfTNg/LK1knJfRnZlSw6bPViMe7f6rO7EnhJT70/ynuhCyckcGX7jTtbXeQKt
         2vSM6toGHApZ7zNN0z/Dx/rKKsIcO0NxF+BaEaFCaqpcg3dWIiOQFi9uG+FLI2QxLPs8
         o7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nj6AGUIJ7Jw7C42GYP493nnjCycIg/FsZyXH/brwYqM=;
        b=DWngnfiTA4ebGTES2jCrWlSpN2JPZIuPylyvFwOR/E3l2C9OZ1nGJ7nfc8gq0vzbkd
         VTLYTEGW+Fbrx6r6e7rJ7AImWpVWXrfcZTzMz+VLKqdGzq268LuP/TrAqknZdnvMj/GR
         Gz8gdqlZ7Q5ZiSU40ef2uFDRJ+qH2/9bIXB06GgrlCd2Sq7480kWkIta9D2T3oK+Rwlv
         YoxFI7K1O1yY61rQNaKd+j+ArrOubbqNwIPWd1HUIDU5LAqCwGbcvYjY8DcZHPbB4gDq
         gjlqAEZmMpiFJyZAS+uZFmq3/HZYfmhbHv4h7DjgI/hrVQ+BgYNeV1pOnLi1aFp5Wjwn
         r82A==
X-Gm-Message-State: AOAM532pl3LFnUzBZI+fdS5Jfg1KhLQAerGaaCn7RD/YF3ZZY2ODPHRV
	L+BLf0E0Fgu533Xf6kubNVywJkgUb8mmVxMbtEdyYQ==
X-Google-Smtp-Source: ABdhPJw8lU3yRVHM/fh5xFfeV/2lusNu7NP06cEVuKk31B0s4gHJCXxGyQqjs5Nj23YOF8vW3mky0FSg74V0nI0Aags=
X-Received: by 2002:a25:b19d:: with SMTP id h29mr6827821ybj.133.1607554291400;
 Wed, 09 Dec 2020 14:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20201209214506.29501-1-JPEWhacker@gmail.com>
In-Reply-To: <20201209214506.29501-1-JPEWhacker@gmail.com>
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
Date: Wed, 9 Dec 2020 23:51:20 +0100
Message-ID: <CAP71WjwprQORv=PYTPAqhO2nEaisUQFohEAEob5Wok5N2Z8sMw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] hashserv: Fix broken AF_UNIX path length limit
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Anuj Mittal <anuj.mittal@intel.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 9, 2020 at 10:45 PM Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Fixes the bug were long paths would break Unix domain socket clients
> (for real this time; the previous attempt was missing os.path.basename).
>
> Adds some tests to prevent regressions
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Thanks, it's fixing the issue I just reported.. I ran a new build on
our Jenkins with master + this patch applied, and it no longer fails.
With that,
Tested-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

> ---
>  bitbake/lib/hashserv/client.py |  2 +-
>  bitbake/lib/hashserv/tests.py  | 29 +++++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
> index 7bbf0865d5..0ffd0c2ae2 100644
> --- a/bitbake/lib/hashserv/client.py
> +++ b/bitbake/lib/hashserv/client.py
> @@ -213,7 +213,7 @@ class Client(object):
>          cwd = os.getcwd()
>          try:
>              os.chdir(os.path.dirname(path))
> -            self.loop.run_until_complete(self.client.connect_unix(path))
> +            self.loop.run_until_complete(self.client.connect_unix(os.path.basename(path)))
>              self.loop.run_until_complete(self.client.connect())
>          finally:
>              os.chdir(cwd)
> diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
> index 3dd9a31bee..77a19b8077 100644
> --- a/bitbake/lib/hashserv/tests.py
> +++ b/bitbake/lib/hashserv/tests.py
> @@ -23,7 +23,8 @@ def _run_server(server, idx):
>      sys.stderr = sys.stdout
>      server.serve_forever()
>
> -class TestHashEquivalenceServer(object):
> +
> +class HashEquivalenceTestSetup(object):
>      METHOD = 'TestMethod'
>
>      server_index = 0
> @@ -65,6 +66,8 @@ class TestHashEquivalenceServer(object):
>          result = client.get_unihash(self.METHOD, taskhash)
>          self.assertEqual(result, unihash)
>
> +
> +class HashEquivalenceCommonTests(object):
>      def test_create_hash(self):
>          # Simple test that hashes can be created
>          taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
> @@ -240,15 +243,33 @@ class TestHashEquivalenceServer(object):
>          self.assertClientGetHash(self.client, taskhash4, None)
>
>
> -class TestHashEquivalenceUnixServer(TestHashEquivalenceServer, unittest.TestCase):
> +class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
>      def get_server_addr(self, server_idx):
>          return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
>
>
> -class TestHashEquivalenceTCPServer(TestHashEquivalenceServer, unittest.TestCase):
> +class TestHashEquivalenceUnixServerLongPath(HashEquivalenceTestSetup, unittest.TestCase):
> +    DEEP_DIRECTORY = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb/ccccccccccccccccccccccccccccccccccccccccccc"
> +    def get_server_addr(self, server_idx):
> +        os.makedirs(os.path.join(self.temp_dir.name, self.DEEP_DIRECTORY), exist_ok=True)
> +        return "unix://" + os.path.join(self.temp_dir.name, self.DEEP_DIRECTORY, 'sock%d' % server_idx)
> +
> +
> +    def test_long_sock_path(self):
> +        # Simple test that hashes can be created
> +        taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
> +        outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
> +        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
> +
> +        self.assertClientGetHash(self.client, taskhash, None)
> +
> +        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
> +        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
> +
> +
> +class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
>      def get_server_addr(self, server_idx):
>          # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
>          # If IPv6 is enabled, it should be safe to use localhost directly, in general
>          # case it is more reliable to resolve the IP address explicitly.
>          return socket.gethostbyname("localhost") + ":0"
> -
> --
> 2.29.2
>
