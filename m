Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id EF0086C3E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 12:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ACD149C02F6;
	Thu, 21 Nov 2019 07:54:49 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 74IHvWMJsjdA; Thu, 21 Nov 2019 07:54:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C075A9C02B1;
	Thu, 21 Nov 2019 07:54:48 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id c9kdXuhpNX5a; Thu, 21 Nov 2019 07:54:48 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 92A079C0189;
	Thu, 21 Nov 2019 07:54:48 -0500 (EST)
Date: Thu, 21 Nov 2019 07:54:48 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <1635304206.602073.1574340888084.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <df6a4b5e-b2b8-900e-bc48-1ff6c35bde36@kernel.crashing.org>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191120093412.11519-8-jean-marie.lemetayer@savoirfairelinux.com>
	<df6a4b5e-b2b8-900e-bc48-1ff6c35bde36@kernel.crashing.org>
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC78 (Linux)/8.8.11_GA_3737)
Thread-Topic: tests/fetch.py: add npm tests
Thread-Index: TteImmjPxjfjwcGmF+ow7MyOjRpOZg==
Cc: paul eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>
Subject: Re: [PATCH v3 7/7] tests/fetch.py: add npm tests
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
X-List-Received-Date: Thu, 21 Nov 2019 12:54:49 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On Nov 20, 2019, at 7:29 PM, Mark Hatle mark.hatle@kernel.crashing.org wrote:
> First thanks for the tests!  A few comments inline
> 
> On 11/20/19 3:34 AM, Jean-Marie LEMETAYER wrote:
>> +
>> +    @skipIfNoNpm()
>> +    @skipIfNoNetwork()
>> +    def test_npm_no_network_no_tarball(self):
>> +        url =
>> 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
>> +        self.d.setVar('BB_NO_NETWORK', '1')
> 
> Since this is a BB_NO_NETWORK=1 case, the @skipIfNoNetwork() should not be here,
> since it should not need the network to perform the test.

Yes it is correct. In fact the @skipIfNoNpm() is not useful either as the
bb.fetch2.NetworkAccess exception should be raised before any npm commands.

>> +        fetcher = bb.fetch.Fetch([url], self.d)
>> +        with self.assertRaises(bb.fetch2.NetworkAccess):
>> +            fetcher.download()
>> +
>> +    @skipIfNoNpm()
>> +    @skipIfNoNetwork()
>> +    def test_npm_no_network_with_tarball(self):
>> +        url =
>> 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
>> +        fetcher = bb.fetch.Fetch([url], self.d)
>> +        fetcher.download()
>> +        self.d.setVar('BB_NO_NETWORK', '1')
> 
> Same here.
> 
> If any other the ones below work off local files, then similarly we shouldn't
> skip running them on a no network config.

As the DL_DIR point to a temporary directory created in the FetcherTest::setUp()
function when starting the test suite I think there is no way to work with local
files if you haven't download it first (which implies a network access).
Or did I miss something ?

>> +        fetcher = bb.fetch.Fetch([url], self.d)
>> +        fetcher.download()
>> +        fetcher.unpack(self.unpackdir)
>> +        unpackdir = os.path.join(self.unpackdir, 'npm')
>> +        self.assertTrue(os.path.exists(os.path.join(unpackdir,
>> 'package.json'))

Regards,
Jean-Marie

