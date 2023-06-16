Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43FEB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 16:01:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.2519.1686931297434347935
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 09:01:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC341FB;
	Fri, 16 Jun 2023 09:02:20 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700493F71E;
	Fri, 16 Jun 2023 09:01:36 -0700 (PDT)
Message-ID: <622e51b1-282b-c1c4-0bdc-3deec8cc76ce@arm.com>
Date: Fri, 16 Jun 2023 17:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel] [PATCH 5/5] bitbake: Bootstrap pytest for
 self-tests
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20230616123651.915234-1-peter.hoyes@arm.com>
 <20230616123651.915234-6-peter.hoyes@arm.com>
 <CANNYZj-5=DY7ZQYzBrp52cSyP3tA6H_Rn73FQgHrijWQqTye-g@mail.gmail.com>
Content-Language: en-US
From: Peter Hoyes <Peter.Hoyes@arm.com>
In-Reply-To: <CANNYZj-5=DY7ZQYzBrp52cSyP3tA6H_Rn73FQgHrijWQqTye-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 16:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14845


On 16/06/2023 13:53, Alexander Kanavin wrote:
> On Fri, 16 Jun 2023 at 14:38, Peter Hoyes <peter.hoyes@arm.com> wrote:
>> From: Peter Hoyes <Peter.Hoyes@arm.com>
>>
>> To support running the bitbake self-tests using pytest, add a
>> pytest.ini This enables these tests to be run using the following
>> command from the bitbake directory.
>>
>>    pytest
>>
>> For now, testpaths only includes the bitbake selftests.
>>
>> Add a note to the README.
>>   bitbake/lib/bb/tests/conftest.py | 8 ++++++++
>> diff --git a/bitbake/lib/bb/tests/conftest.py b/bitbake/lib/bb/tests/conftest.py
>> new file mode 100644
>> index 0000000000..59a8c6753b
>> --- /dev/null
>> +++ b/bitbake/lib/bb/tests/conftest.py
>> @@ -0,0 +1,8 @@
>> +import pathlib
>> +import pytest
>> +
>> +BB_BIN_PATH = pathlib.Path(__file__).parents[3].resolve() / 'bin'
>> +
>> +@pytest.fixture(autouse=True)
>> +def bitbake_path(monkeypatch):
>> +    monkeypatch.setenv('PATH', str(BB_BIN_PATH), prepend=':')
> The addition and purpose of this file should be explained.
>
> Alex

"conftest.py" is a pytest feature [1] for test module-specific 
configuration, which is ignored by unittest.

The intention here is to automatically configure the PATH to avoid extra 
manual steps after checkout. I can either add a comment to this effect 
in v2, or drop this file and require the user to manually configure the 
PATH, as for bitbake-selftest.

Peter

[1] 
https://docs.pytest.org/en/7.3.x/reference/fixtures.html#conftest-py-sharing-fixtures-across-multiple-files


