Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3C78A73243
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Aug 2016 05:41:22 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 18 Aug 2016 22:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,543,1464678000"; d="scan'208";a="1028179640"
Received: from aberic-mobl5.ger.corp.intel.com (HELO [10.252.19.32])
	([10.252.19.32])
	by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2016 22:41:20 -0700
User-Agent: Microsoft-MacOutlook/14.6.6.160626
Date: Fri, 19 Aug 2016 08:41:17 +0300
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Message-ID: <D3DC759A.660C3%markus.lehtonen@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/4] bitbake-selftest: utilize
	unittest.main better
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
	<1471539354-32382-2-git-send-email-markus.lehtonen@linux.intel.com>
	<1471539833.16712.19.camel@linuxfoundation.org>
In-Reply-To: <1471539833.16712.19.camel@linuxfoundation.org>
Mime-version: 1.0
Subject: Re: [PATCH 1/4] bitbake-selftest: utilize unittest.main better
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
X-List-Received-Date: Fri, 19 Aug 2016 05:41:23 -0000
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit

On 18/08/16 20:03, "Richard Purdie" <richard.purdie@linuxfoundation.org>
wrote:

>On Thu, 2016-08-18 at 19:55 +0300, Markus Lehtonen wrote:
>> This simplifies the script, and, gives new features. It is now
>> possible
>> to run single test functions, for example. This is nice when writing
>> new
>> test cases.
>> 
>> Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
>> ---
>>  bin/bitbake-selftest | 30 ++++++++----------------------
>>  1 file changed, 8 insertions(+), 22 deletions(-)
>> 
>> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
>> index 1e6f35e..1e615cc 100755
>> --- a/bin/bitbake-selftest
>> +++ b/bin/bitbake-selftest
>> @@ -25,31 +25,17 @@ try:
>>  except RuntimeError as exc:
>>      sys.exit(str(exc))
>>  
>> -def usage():
>> -    print('usage: [BB_SKIP_NETTESTS=yes] %s [-v] [testname1
>> [testname2]...]' % os.path.basename(sys.argv[0]))
>
>Could we at least preserve the usage message which is helpful as I can
>never remember BB_SKIP_NETTESTS=yes without prompting...

I didn't find an easy way to add that to the usage string. However, patch
#2 ("bitbake-selftest: add help text for env variable(s)") adds a note
about BB_SKIP_NETTESTS that gets printed if you use --help. Would this be
ok?

Thanks,
  Markus



