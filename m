Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.92.73.75])
 by mx.groups.io with SMTP id smtpd.web10.21840.1627919166426234991
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 08:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=TqgDYyd/;
 spf=pass (domain: outlook.com, ip: 40.92.73.75, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxYYnLHPRxMCNG4EGPXKVjLsA28LO2+VMacvD+BbpFM24d9A2daapNY8ENDcGyF+q/aewkNWAFe02xU7d/11S5lHwwjh7YqBYu6/pmprszGWlVaoIfRIZPwah7EbQ7S8VvYsrIrEzY9VMQTpuFD1Co5Bj4akL46dn4eXOv9cdYrdl7rcEUbtJm+dUV9uN0SoiNKOPPZFkZKk0WRCGKzn54VB4HWgnn1tZPBkl6/U7g6vmdCvN+PCZFJ4g96Q2HRRiuqHCAUH7G6nPhcgDNbTz2S1EI7GdTAeli0xyqNuJ/Rexg4mbEvs/TLvM2ETMZYqkBFCIvu6asWW002u+Eq/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9k8JhuPTJgI0u6P/i2JRK0IMSqA+PllWmhm/vT4qUU=;
 b=GbbbEMLqOTpGmTuNXzomwQ/JIwKZUzke7uxzC6iAocGWG2bpWh4MCgUygjYCF8O995kXR9RTVXRQnqvvd/oVc4+01biuXk8YY7RdCSHn0omTQbpu2X0J0mpoGjh8zHg8gf0h7NfsqUgMmHGtcjJsIldF63S8KLntXFa6+ILbQkSyAFhTTcRPi2/N4FTJhUZrsCzWzTN9YvWRtarWHEe8Jr9t9+5iyGtyHKaQQaV1CLwJ9PGpdaqzb7m52BsmfumhdJC+BF4Rs3P1bQpCK+/h62qF1Rl/FSkDFv3Iv9785P+Q5GeHK61wlUTDqkEM/wqlS+YxzQpIXp6U6Ph1BeCjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9k8JhuPTJgI0u6P/i2JRK0IMSqA+PllWmhm/vT4qUU=;
 b=TqgDYyd/WV2JO1D7rHKjGQ6RGh9A2rRyLryciG3ciCTzYa9tDJ9EZxJtEewROSytwJWd7/HdMDV1QEfVDvyIp0J2O2r8Sp6VvpiljX33m/fO8IWhVsz1ATIBEMMrHdf0vCELs2LViVOmiNGXxzsbSCTyetfWxR8e/ZPAcTB3ngi2bicjAmXtgZ1QP4wqXB9uG4xJDeyKWKqZ8cHRZjVhiSs+RY01LC714W2pwVxEyMtnIk4woxH+p8TnNkpE3L1/I1CUQP886jtjPxdb9TiDQsHyyJXoYhp1fN0d5indBI4v3Kp4xA34Wen3NipBnUKl2H/+v7Tc54O8xoPw2mKUpg==
Received: from DB3EUR04FT056.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::4b) by
 DB3EUR04HT075.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::332)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 15:46:04 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:7e0c::43) by DB3EUR04FT056.mail.protection.outlook.com
 (2a01:111:e400:7e0c::69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 15:46:04 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:0213DCD7FFAE44DD7B315B75839915DFFC88889366413425F133F330341882F3;UpperCasedChecksum:BFB0C0C983F7A7212AE93B854BC77526F07A7D0BE51044BD0A5AA2A5CF745A50;SizeAsReceived:8907;Count:47
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::411f:efb1:4a12:95b7]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::411f:efb1:4a12:95b7%8]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 15:46:04 +0000
Subject: Re: [bitbake-devel] [PATCH] data_smart: Fix inactive overide accidental variable value corruption
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB46429863371012A2E7080F37A8EF9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Mon, 2 Aug 2021 17:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
X-TMN: 
 [hOsLvx0xa6kczdZA3CDBZ7dpbXHo5hj1bdwP82RB8+N6i3BkVSLgEG4HWTjA2SXBXyAKeay4Lt8=]
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: 
 <0ec5350e-0a56-5e39-0f1c-2018ee77a5f2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:8109:9a80:3b94:19cb:1ee8:a90f:12a0] (2a02:8109:9a80:3b94:19cb:1ee8:a90f:12a0) by AM8P251CA0006.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 15:46:03 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d6286908-a0a1-4218-8f94-08d955cca28d
X-MS-TrafficTypeDiagnostic: DB3EUR04HT075:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+0A6xFjc8OkRslYESd1I9h7w5EsTD8B83E/b61axMfZiQ5BaJIZV+tb3BV3wUE1XJzwqpBAqu2DcrtHPZOxNTGFx0r8pl0VJd3tj1e1B6z9elxK1dqJTNl2G9Yt++Z8falaNUONlKs9X0rClKqhNg4l+8o9f7O4nsJntkxybBG65XtcEgotuE/gdcG+0nypRJ/L1VrqqFjSB+Zy0CeOKBD6Ofv910KY/wd2+9Kmn8kNUoFycSSckcHU7vuCjMbVhc+odSx8oM1KuRKp67kyRjtPXDFoQIbJEUBeSCmXsCMNZN56m5Dj0XbjYzz5bUa2jCuYk3YIvn6VcCfmZbH99ElaIP64ktIXzSi8+G27iyALNl2mCi+pOTNmA7h6B2aoBW0RnZ+7uFWgA66nLmLnfRNcdfWXl9SK+mfvWNFxv3ZoMeKTllppB8xRZVty0LLnwrwqrtkLIn3XM6zlizORr117f9YZ2fKSKqDfMCvWR4DY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	j5yq+IpzFTFwKSIfiDD/2rRRdMX5aAJ3mIgMH9qK8DGtTM9QlKsWfNulbR7/gScP1LUVkeffnyRr6SYUU3Df+js/Kbesa/3d9mbwnM+pVM9IiFErmWqxuscp9BJiz8ZDbNEy97GlBOCjHUcv1YS3M9FqdC8EmTPWcHrYNVGs1t15qYG54u9sI5FFuZWJGagpQqomA/IjKAgcvuwNdE6fOg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6286908-a0a1-4218-8f94-08d955cca28d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 15:46:04.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	DB3EUR04FT056.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT075
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 02.08.21 17:42, Richard Purdie wrote:
> Setting something like:
> 
>    BAR:append:unusedoverride
> 
> should cause BAR to be None, not "" which was what the datastore was
> returning. This caused problems when mixing variables like:
> 
>    RDEPENDS:${PN}:inactiveoverride
>    RDEPENDS:${BPN}
> 
> since key expansion would report key overlap when there was none. This
> is a bug in the datastore. Fix it and add a test too.
> 
> [YOCTO #14088]
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/data_smart.py | 8 ++++----
>   lib/bb/tests/data.py | 5 +++++
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 43e9e78555..65528c6ae6 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
>   
>   
>           if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
> -            if not value:
> -                value = ""
>               self.need_overrides()
>               for (r, o) in local_var[":append"]:
>                   match = True
> @@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
>                           if not o2 in self.overrides:
>                               match = False
>                   if match:
> +                    if value is None:
> +                        value = ""
>                       value = value + r
>   
>           if flag == "_content" and local_var is not None and ":prepend" in local_var and not parsing:
> -            if not value:
> -                value = ""
>               self.need_overrides()
>               for (r, o) in local_var[":prepend"]:
>   
> @@ -774,6 +772,8 @@ class DataSmart(MutableMapping):
>                           if not o2 in self.overrides:
>                               match = False
>                   if match:
> +                    if value is None:
> +                        value = ""
>                       value = r + value
>   
>           parser = None
> diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
> index 7f1d3ffbbc..e667c7c7d3 100644
> --- a/lib/bb/tests/data.py
> +++ b/lib/bb/tests/data.py
> @@ -405,6 +405,11 @@ class TestOverrides(unittest.TestCase):
>           bb.data.expandKeys(self.d)
>           self.assertEqual(self.d.getVar("VERSION"), "2")
>   
> +    def test_append_and_unused_override(self):
> +        # Had a bug where an unused override append could return "" instead of None
> +        self.d.setVar("BAR:append:unusedoverride", "testvalue2")
> +        self.assertEqual(self.d.getVar("BAR"), None)

Maybe I'm not seeing it but to me the test doesn't match the changes made.
If the code change turns None into "", how can the assert ever work here?
I would have expected assertNotEqual or similar here

> +
>   class TestKeyExpansion(unittest.TestCase):
>       def setUp(self):
>           self.d = bb.data.init()
> 
> 
> 
> 
> 
