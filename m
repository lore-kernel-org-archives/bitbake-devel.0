Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.92.91.62])
 by mx.groups.io with SMTP id smtpd.web10.6369.1592044487786550256
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Jun 2020 03:34:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=h6MogRNE;
 spf=pass (domain: outlook.com, ip: 40.92.91.62, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmTU4ESpCg+gHoTY+pciqN8YC3AQzKfc9ByvTuQOCAIlaGIXatpc3WQZYkj/0K985XcPfGwFufKoL6md51TJZIFtx0uFYVnET7+W85TC3Qp+MTasiSE3cfIO287rG3BgI5jm84QtOreEIbjpPwyeMZAwuHRkgApkOLwb/QXiEiEmMMYTYLG+PVhRrByLwVxKdcLS/+afYrZxFZuKIGWqej3XfElJ7J54KhUpR6alBG2o6pYNwI5Z8OiD93fTHFmlauGy4kWCVvgioGp2Y5EyEtbiDI7TDH3nYJSsqiSZAkOd6bXVzrZGZ78U06OiW/jvaV2N54imXqVTiSn5EmLCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAOdPdGSXTf+xyimbfw3aIbjiH6vaRHaqCI9SpEuZW0=;
 b=Zg8UMS2NWphGNZkU0pHwrfGmyHBK/4iC26dSNBsj5AsqkejFDQEiwg7F8b1+/GrKk1gLyIAKUKNKyl+KI+oaWH6Ki46gqHvqIh4J2PnRuiUVlAo7SZ8WTZk/UqUrv9Dr3QqqMua1jhFDDuGWIgx0v/9O9j9N/h8f9IBrlXu0RAuLzI/WOkU7+RvJLZR+aA7FiEHPsZbOn6Kfvu+Gmec8ruSOlqXulRIKSlEOzwO1tYIwztnOuv4EwAvWqQT8ZkPZn33AVwytG/PZju5XPdPHGWzHD8SdolNkJUanrPKfq27w2SCS3w9c6VAxDiysS4cx7Gh61fnHoKte4X4pA3UYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAOdPdGSXTf+xyimbfw3aIbjiH6vaRHaqCI9SpEuZW0=;
 b=h6MogRNEzgwaOiAtbIZCyrsAuppWcZHqOm7YhZa4UMc6WHoih7xdnyD0pnBbeqe5FHWMIfm6XFa00e7hAadXQaLls6kEg5TZvXyuEyHNtQaDSCaOdBsiMhFoi6typYDt966V9yJiiXwe7P8X34suF1rcREimUiqdN+GK3c6f5cG0T/h4heUn1eylSU5m6HWe634HSj4Xvpf3bGMWTDGy8Hqk1dqRCgXG33eGPD08Jpep39yccZ9mNA+Pjr1kBza7aqpd4dgJeiEDZjHCduzzBudMpNjkBEDmm2wKh3oOxqlg+f4TLwOVYPYSDHXi49WOFH1JMtZwaEilAYp667omsg==
Received: from AM6EUR05FT052.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::50) by
 AM6EUR05HT034.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::339)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sat, 13 Jun
 2020 10:34:45 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:fc11::4b) by AM6EUR05FT052.mail.protection.outlook.com
 (2a01:111:e400:fc11::128) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sat, 13 Jun 2020 10:34:45 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:F4F294F1104C87E94195923A22F118B549F983A072BCFC3ADF9A5CFA19F897B5;UpperCasedChecksum:1BE58740F882DDF1902BB6B5CBE35F36EA882070A6D370B081C1B702C8A5063C;SizeAsReceived:8706;Count:48
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722%7]) with mapi id 15.20.3088.025; Sat, 13 Jun 2020
 10:34:45 +0000
Subject: Re: [bitbake-devel] [PATCH v2] BBFILES_DYNAMIC: add inverse mode
To: bitbake-devel@lists.openembedded.org
References: <160AAE7A27E24EAF.22530@lists.openembedded.org>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: 
 <AM7PR05MB6881BCFF510297F50FE36E9DA89E0@AM7PR05MB6881.eurprd05.prod.outlook.com>
Date: Sat, 13 Jun 2020 12:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <160AAE7A27E24EAF.22530@lists.openembedded.org>
X-ClientProxiedBy: AM6PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::41) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: 
 <bc311eea-f296-58de-5d13-8fcb0336fcbb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.188.20] (79.215.11.32) by AM6PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:20b:92::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Sat, 13 Jun 2020 10:34:45 +0000
X-Microsoft-Original-Message-ID: 
 <bc311eea-f296-58de-5d13-8fcb0336fcbb@outlook.com>
X-TMN: [eUEiEpRO0s7Z5i9ljOLusMCPnQXK02Da]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1a7edee4-361b-4641-6789-08d80f8563e3
X-MS-TrafficTypeDiagnostic: AM6EUR05HT034:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o/3K0y4cIeRHxDgl8LfNqlTATAk2QTBQIqzhvIZAG0yQuyhPPgH7OkS3XSlN9yEICyqmj6JTP8fbaJTXJ0M94kp2W321J8GiNmRqDNR9+Sxoc57LZ2z/gU/1MUmkp+JqbELtsvQOVRaNmrxD+OLuOm3lbFTLMosEPTqQwV/D4MqLzWoy0KKWa6TFtfbdJ48rHdQqZICNVjrSwoP8DhguT7neP/5vq/Bijz0cr0k/aD07Jigpgxe5I/SFs27XRvSO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	AoSQHTVqpV8FKEgq+1B7uvnIZ9y22XsyollcUQ18JUyq/yCOZWIxCsc7TJtvtHgPcOai/6owFvWI1R+lEvc62m1MYFUKmsyMQhIHTDANrw8QtTptkTfG4+A+v4bC3I7hBp7oJXFg6myQKr/eEsAx/w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7edee4-361b-4641-6789-08d80f8563e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 10:34:45.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT034
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Friendly reminder.
If the patch isn't applicable for some reason: I'd like to ask how I 
could 'emulate' the patch.

If I read the code correctly it isn't possible to do the same as part of 
the layer.conf, as the list is filled one layer.conf after another and 
so the existence of a layer name in BBFILE_COLLECTIONS is dependent on 
the order in BBLAYERS - which makes it prone to errors.

I currently have some recipes which are provided by some optional layer, 
but as they tend to provide/override more than needed (in this case just 
a single recipe) it would be nice to have that backfill possibility.
So it's up to the user to choose if the full layer meets his needs or 
the backfill recipe is just enough.

Looking forward to some feedback.
Regards
Konrad

On 30.04.20 21:07, Konrad Weihmann wrote:
> Add an inverse mode for BBFILES_DYNAMIC.
> Entries where the layername is prefix with '!' will act in inverted mode
> including given glob mask in absence of the referenced layer.
> This is useful to backfill recipes from potentially missing layer.
> 
> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
> ---
>   lib/bb/cookerdata.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 472423fd..bf72a8b3 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -387,7 +387,10 @@ class CookerDataBuilder(object):
>                       invalid.append(entry)
>                       continue
>                   l, f = parts
> -                if l in collections:
> +                invert = l[0] == "!"
> +                if invert:
> +                    l = l[1:]
> +                if (l in collections and not invert) or (l not in collections and invert):
>                       data.appendVar("BBFILES", " " + f)
>               if invalid:
>                   bb.fatal("BBFILES_DYNAMIC entries must be of the form <collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
> 
> 
> 
> 
