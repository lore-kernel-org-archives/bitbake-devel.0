Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8EC433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Jul 2022 10:10:45 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web09.20464.1657707036306325749
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Jul 2022 03:10:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YMl43TdW;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id d12so18241342lfq.12
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Jul 2022 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cllepA4b3y6ZioSHonOsDQUpjJrbrU6q7BX6OikVfXQ=;
        b=YMl43TdWr0h6EtRYoTU4PuwnuEcYAK8NV2KQAGprTUYvzokZes2V/h8U1eXHPSfyse
         vlori2xY+weoZ97RS6Olf52xcJkWS5xdmvcLlVECn3ZD2VxOxu9XIcmiO+f1SmKLPyOr
         P37J1jO+Qr2FEWBBhOrIATKBVzKjC9yQTfPe+JkeIT5RgjuDenXJ7aTVT4FZbW1Yp+3s
         XK1nANsTotSbHUgnF49OFVIrre8vREXqwlr4GZKC3Uw0NpUmmXYXYl3iZTm6yjJl1Ebv
         +lOTbGvLNlrQb4+4Ov5G3ijm6LKOChX6MgMtLVDXEmbYrFak+ejkdAfNSps8Bi3jqMRH
         fqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cllepA4b3y6ZioSHonOsDQUpjJrbrU6q7BX6OikVfXQ=;
        b=tYke+h0x3cBK59bPWn/xNRtePwzft4NmVLJ2hN8r4zXW1yJndIE1POj8qhUxem6z+P
         KvF/0KG4oNz9wYMVHTU5UWwO/tTgBdzb4y8kvjoxRwAKckCea+3+HhgANHL6rkhWrv2W
         YdaZvoo/D/MZ/74WwYBQ9/5MVhFnswoXKcUUWu3O4LDylfTGjmcfzIATHBZAQkG4yoVj
         +NETfapzBa0t0NOIxMsLzz5tc70nyU0jTU6NcZflsw1kd/GJ6CZDcD8MygYN37wYfhy9
         sHRHWGsmJxaVs3b82VVzJe2N98zrutd+MSZfQKQhbD5vJoFBJzRFpiA2lWcvINYp2I5/
         f1Ug==
X-Gm-Message-State: AJIora8Hekv8JhlaQMyRr8i7dA0LkxX4nLfZpJYKAVWJ1wS1Gdr1XaZf
	i5k1fEH7YoCEffYJ36i4Ow==
X-Google-Smtp-Source: 
 AGRyM1uzTtMONWXjjgQNN/KyF/hMvWiq93+XSVFdxArlHFvNJry2oBHoC/2rdqs2SN3X3L/vMo4DIA==
X-Received: by 2002:a05:6512:22d6:b0:488:fb63:1489 with SMTP id
 g22-20020a05651222d600b00488fb631489mr1613840lfu.477.1657707033959;
        Wed, 13 Jul 2022 03:10:33 -0700 (PDT)
Received: from [192.168.1.10] (83.11.65.125.ipv4.supernova.orange.pl.
 [83.11.65.125])
        by smtp.gmail.com with ESMTPSA id
 f2-20020ac25cc2000000b00488d1acb7b0sm2709501lfq.130.2022.07.13.03.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:10:33 -0700 (PDT)
Message-ID: <4c6a0dd9-641d-9331-ff3a-1ca6d02f4dd8@gmail.com>
Date: Wed, 13 Jul 2022 12:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com> <Ys6U7V+xOe7/2Pso@mail.local>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: <Ys6U7V+xOe7/2Pso@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Jul 2022 10:10:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13823

Hello,

Well this illustrates the kind of issue I wanted to catch, but this 
test's condition will now not be reachable at all.
Previously, the checksum failed with only a warning, while the failure 
occurred in the download stage of the local fetcher.
Now as the checksum fails and it is immediately fatal there is no way to 
reach a download state at all.

Should this test be removed, then? In my patch i added the appropriate 
test and it is in the bitbake self test which does not depend on poky or 
openembedded core. Let me know what you think.

Paulo Neves


On 7/13/22 11:48, Alexandre Belloni wrote:
> Hello,
>
> I believe this is the cause of the following failure:
>
> 2022-07-13 08:32:51,511 - oe-selftest - INFO - bbtests.BitbakeTests.test_invalid_recipe_src_uri (subunit.RemotedTestCase)
> 2022-07-13 08:32:51,512 - oe-selftest - INFO -  ... FAIL
> 2022-07-13 08:32:51,512 - oe-selftest - INFO - 3: 18/58 119/493 (3.15s) (bbtests.BitbakeTests.test_invalid_recipe_src_uri)
> 2022-07-13 08:32:51,512 - oe-selftest - INFO - testtools.testresult.real._StringException: Traceback (most recent call last):
>    File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/selftest/cases/bbtests.py", line 148, in test_invalid_recipe_src_uri
>      bitbake('-ccleanall man-db')
>    File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/utils/commands.py", line 229, in bitbake
>      return runCmd(cmd, ignore_status, timeout, output_log=output_log, **options)
>    File "/home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/lib/oeqa/utils/commands.py", line 207, in runCmd
>      raise AssertionError("Command '%s' returned non-zero exit status %d:\n%s" % (command, result.status, exc_output))
> AssertionError: Command 'bitbake  -ccleanall man-db' returned non-zero exit status 1:
> /usr/lib64/python3.6/importlib/_bootstrap.py:219: ImportWarning: can't resolve package from __spec__ or __package__, falling back on __name__ and __path__
>    return f(*args, **kwds)
> NOTE: Reconnecting to bitbake server...
> Loading cache...done.
> Loaded 1718 entries from dependency cache.
> Parsing recipes...ERROR: /home/pokybuild/yocto-worker/oe-selftest-centos/build/meta/recipes-extended/man-db/man-db_2.10.2.bb: Unable to get checksum for man-db SRC_URI entry invalid: file could not be found
> ERROR: Parsing halted due to errors, see error messages above
>
> I guess you have to update
> bbtests.BitbakeTests.test_invalid_recipe_src_uri too
>
> On 08/07/2022 22:54:07+0200, Paulo Neves wrote:
>> If the local fetcher was not able to find the file anywhere but it
>> was included in the SRC_URI for checksumming just make it a fatal
>> error.
>> ---
>>   lib/bb/fetch2/__init__.py | 2 +-
>>   lib/bb/tests/fetch.py     | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 5f05278a..8184b55e 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
>>                               " This means there is no way to get the file except for an orphaned copy"
>>                               " in DL_DIR.") % (d.getVar('PN'), os.path.basename(f)))
>>                       else:
>> -                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
>> +                        bb.fatal("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
>>                   filelist.append(f + ":" + str(os.path.exists(f)))
>>   
>>       return " ".join(filelist)
>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>> index 3ebd9fd7..5b577b06 100644
>> --- a/lib/bb/tests/fetch.py
>> +++ b/lib/bb/tests/fetch.py
>> @@ -700,6 +700,11 @@ class FetcherLocalTest(FetcherTest):
>>           with self.assertRaises(bb.BBHandledException):
>>               bb.fetch.get_checksum_file_list(self.d)
>>   
>> +    def test_local_checksum_fails_no_file(self):
>> +        self.d.setVar("SRC_URI", "file://404")
>> +        with self.assertRaises(bb.BBHandledException):
>> +            bb.fetch.get_checksum_file_list(self.d)
>> +
>>       def test_local(self):
>>           tree = self.fetchUnpack(['file://a', 'file://dir/c'])
>>           self.assertEqual(tree, ['a', 'dir/c'])
>> -- 
>> 2.25.1
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#13813): https://lists.openembedded.org/g/bitbake-devel/message/13813
>> Mute This Topic: https://lists.openembedded.org/mt/92260795/3617179
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>


