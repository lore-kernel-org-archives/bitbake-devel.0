Return-Path: <chanm@cisco.com>
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	by mail.openembedded.org (Postfix) with ESMTP id 84AD16A456
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jun 2013 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=cisco.com; i=@cisco.com; l=2161; q=dns/txt; s=iport;
	t=1370526912; x=1371736512;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	content-id:content-transfer-encoding:mime-version;
	bh=TW0SaVnjR8B0SsEu6EnDsx+b2D81uhL4hsfyCj2b58o=;
	b=SlWj8MDd1VqmLzh+fSwgy/xMBXU4LXozYCnBoGzr8DtQvKn4/mkfxi1D
	AKjaYdI/XbcupMsunlM6fgOXE9E8pPdAOdVQMSCL4pW2PcMHbeUKEUw+1
	2sMdJ0cl6Jka/n138IBWk/J9pTA5jwhx7Ce2hUt5K90eS9HtDSeYndtaY M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgkFAKuTsFGtJXHB/2dsb2JhbABZgwkwv0d4FnSCIwEBAQQ6NAsSAQgYChRCJQIEDgUIiAW7KI8BMQeCemEDqH+DD4In
X-IronPort-AV: E=Sophos;i="4.87,815,1363132800"; d="scan'208";a="219642872"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
	by rcdn-iport-4.cisco.com with ESMTP; 06 Jun 2013 13:55:11 +0000
Received: from xhc-aln-x05.cisco.com (xhc-aln-x05.cisco.com [173.36.12.79])
	by rcdn-core2-6.cisco.com (8.14.5/8.14.5) with ESMTP id r56DtAXI008136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 6 Jun 2013 13:55:10 GMT
Received: from xmb-rcd-x07.cisco.com ([169.254.7.39]) by xhc-aln-x05.cisco.com
	([173.36.12.79]) with mapi id 14.02.0318.004;
	Thu, 6 Jun 2013 08:55:10 -0500
From: "Ming Chan (chanm)" <chanm@cisco.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] Question on including ruby 1.9.3 in embedded
	image
Thread-Index: AQHOYh0B2KchihXKtkuouOrjdJbvuZkoqwKAgAAccYA=
Date: Thu, 6 Jun 2013 13:55:10 +0000
Message-ID: <A8108027F6475848B4BB89A74BA7AE4319386FD0@xmb-rcd-x07.cisco.com>
In-Reply-To: <1370506401.1640.71.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.4.130416
x-originating-ip: [10.131.36.235]
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 06 Jun 2013 14:21:04 +0000
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Question on including ruby 1.9.3 in embedded image
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Jun 2013 13:55:10 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DE6985F686B684AA7BAE78B93AFA3FA@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable

Hi Richard,=20

We just resolved these issues.

Thanks,

--Ming=20

On 6/6/13 4:13 AM, "Richard Purdie" <richard.purdie@linuxfoundation.org>
wrote:

>On Wed, 2013-06-05 at 18:46 +0000, Ming Chan (chanm) wrote:
>> We are trying to include ruby-1.9.3 by using the recipe in
>> the=20
>>meta-openembedded/meta-ruby(git://git.openembedded.org/meta-openembedded)
>>, Issues seen during the bitbake run:
>>      1. While package ruby-native-1.9.3-p194-r1.0, task do_compile
>>         failed with "undefined symbol: rb_encdb_declare", the work
>>         around this issue is to use --disable-rdoc
>>      2. While package ruby-1.9.3-p194-r1.0, task do_compile failed
>>         with the following:
>>                 template/Doxyfile.tmpl:22: uninitialized constant
>>                 RUBY_REVISION (NameError).  The work around is to use
>>                 0 instead of RUBY_REVISION.
>>               * executable host ruby is required.  The work around is
>>                 to use --with-baseruby option and provide baseruby
>>                 from build machine.
>>               * ext/etc/extconf.rb:8: undefined method `escape' for
>>                 Shellwords.  This issue is caused by the version of
>>                 executable host ruby is to old.  This issue
>>                 disappeared after using ruby-1.8.7 on the build
>>                 machine.
>>               * The current issue is "../.././lib/erb.rb:586:in
>>                 `compile': undefined method `encoding' for
>>                 #<String:0x2a9560fee0> (NoMethodError)"
>> Does it make sense for the work around described?  Any requirement
>> (i.e. The version of gcc) is needed to use  the recipe in
>> the meta-openembedded/meta-ruby?
>>=20
>This mailing list is about bitbake itself, not about metadata and build
>problems. See the README in the meta-opembedded layer for details on
>where to take questions (its the openenembedded-devel mailing list in
>this case).
>
>FWIW it is a bug that you have to work around these issues however the
>quality of recipes in meta-openembedded is variable.
>
>Cheers,
>
>Richard
>
>
>


