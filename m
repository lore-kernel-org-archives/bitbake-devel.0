Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 373087F7C8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 19:18:46 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xALJIVPj002898
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Thu, 21 Nov 2019 13:18:34 -0600
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191120093412.11519-8-jean-marie.lemetayer@savoirfairelinux.com>
	<df6a4b5e-b2b8-900e-bc48-1ff6c35bde36@kernel.crashing.org>
	<1635304206.602073.1574340888084.JavaMail.zimbra@savoirfairelinux.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <697a30c2-d3ae-dd99-18b8-0efa99c56037@kernel.crashing.org>
Date: Thu, 21 Nov 2019 13:18:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1635304206.602073.1574340888084.JavaMail.zimbra@savoirfairelinux.com>
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
X-List-Received-Date: Thu, 21 Nov 2019 19:18:46 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 11/21/19 6:54 AM, Jean-Marie LEMETAYER wrote:
> Hi Mark,
> 
> On Nov 20, 2019, at 7:29 PM, Mark Hatle mark.hatle@kernel.crashing.org wrote:
>> First thanks for the tests!  A few comments inline
>>
>> On 11/20/19 3:34 AM, Jean-Marie LEMETAYER wrote:
>>> +
>>> +    @skipIfNoNpm()
>>> +    @skipIfNoNetwork()
>>> +    def test_npm_no_network_no_tarball(self):
>>> +        url =
>>> 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
>>> +        self.d.setVar('BB_NO_NETWORK', '1')
>>
>> Since this is a BB_NO_NETWORK=1 case, the @skipIfNoNetwork() should not be here,
>> since it should not need the network to perform the test.
> 
> Yes it is correct. In fact the @skipIfNoNpm() is not useful either as the
> bb.fetch2.NetworkAccess exception should be raised before any npm commands.
> 
>>> +        fetcher = bb.fetch.Fetch([url], self.d)
>>> +        with self.assertRaises(bb.fetch2.NetworkAccess):
>>> +            fetcher.download()
>>> +
>>> +    @skipIfNoNpm()
>>> +    @skipIfNoNetwork()
>>> +    def test_npm_no_network_with_tarball(self):
>>> +        url =
>>> 'npm://registry.npmjs.org;name=@savoirfairelinux/node-server-example;version=1.0.0'
>>> +        fetcher = bb.fetch.Fetch([url], self.d)
>>> +        fetcher.download()
>>> +        self.d.setVar('BB_NO_NETWORK', '1')
>>
>> Same here.
>>
>> If any other the ones below work off local files, then similarly we shouldn't
>> skip running them on a no network config.
> 
> As the DL_DIR point to a temporary directory created in the FetcherTest::setUp()
> function when starting the test suite I think there is no way to work with local
> files if you haven't download it first (which implies a network access).
> Or did I miss something ?

I didn't notice thi one has the BB_NO_NETWORK -after- the download.  So ya, I
see how it requires the network.

--Mark

>>> +        fetcher = bb.fetch.Fetch([url], self.d)
>>> +        fetcher.download()
>>> +        fetcher.unpack(self.unpackdir)
>>> +        unpackdir = os.path.join(self.unpackdir, 'npm')
>>> +        self.assertTrue(os.path.exists(os.path.join(unpackdir,
>>> 'package.json'))
> 
> Regards,
> Jean-Marie
> 

