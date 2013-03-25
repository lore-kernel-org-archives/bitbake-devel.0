Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UKEv3-0006Y8-Fr for bitbake-devel@lists.openembedded.org;
	Mon, 25 Mar 2013 22:28:29 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2PLJi8X010563; Mon, 25 Mar 2013 21:19:44 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bxLnSV4CiKJu; Mon, 25 Mar 2013 21:19:44 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2PLJYFE010558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 25 Mar 2013 21:19:37 GMT
Message-ID: <1364245781.3097.72.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Mon, 25 Mar 2013 21:09:41 +0000
In-Reply-To: <1364239962-11399-1-git-send-email-olof.johansson@axis.com>
References: <1364239962-11399-1-git-send-email-olof.johansson@axis.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.tests.fetch: Opt-in for unittests that require network
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 25 Mar 2013 21:28:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-03-25 at 20:32 +0100, Olof Johansson wrote:
> With this change, you have to opt-in to run unit tests that require an internet
> connection. To opt-in, you'll set the environment variable BB_NETTESTS to 'yes'.

Can we do this the other way please and let people opt-out? I'd rather
people make a conscious decision to opt-out than in.

Cheers,

Richard

> Signed-off-by: Olof Johansson <olof.johansson@axis.com>
> ---
>  lib/bb/tests/fetch.py |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 778d94f..d51aace 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -308,6 +308,8 @@ class FetcherTest(unittest.TestCase):
>      def tearDown(self):
>          bb.utils.prunedir(self.tempdir)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_fetch(self):
>          fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
>          fetcher.download()
> @@ -320,12 +322,16 @@ class FetcherTest(unittest.TestCase):
>          self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/")), 9)
>          self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.1/")), 9)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_fetch_mirror(self):
>          self.d.setVar("MIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
>          fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
>          fetcher.download()
>          self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_fetch_premirror(self):
>          self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
>          fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
> @@ -351,21 +357,29 @@ class FetcherTest(unittest.TestCase):
>          fetcher.download()
>          checkrevision(self, fetcher)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_gitfetch(self):
>          url1 = url2 = "git://git.openembedded.org/bitbake"
>          self.gitfetcher(url1, url2)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_gitfetch_premirror(self):
>          url1 = "git://git.openembedded.org/bitbake"
>          url2 = "git://someserver.org/bitbake"
>          self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
>          self.gitfetcher(url1, url2)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_gitfetch_premirror2(self):
>          url1 = url2 = "git://someserver.org/bitbake"
>          self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
>          self.gitfetcher(url1, url2)
>  
> +    @unittest.skipUnless(os.environ.get("BB_NETTESTS") == "yes",
> +                         "Set BB_NETTESTS to yes to run network tests")
>      def test_gitfetch_premirror3(self):
>          realurl = "git://git.openembedded.org/bitbake"
>          dummyurl = "git://someserver.org/bitbake"




