Return-Path: <a.baumfalk@astro-kom.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBC5C77B7A
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 16:07:23 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.101])
 by mx.groups.io with SMTP id smtpd.web10.26076.1684253238247554291
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 May 2023 09:07:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@astro-kom.de header.s=selector2 header.b=WRtn0Ic+;
 spf=pass (domain: astro-kom.de, ip: 40.107.14.101, mailfrom: a.baumfalk@astro-kom.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+UFuDKLEknyxvb6a+peg7JoFMmDD49u9URGoSRZtLHPk7/gxehWqROyzCxdrPaf9spEmjZjvQSaTlddyaHNj+WvlqCaDyRwWlnhfFy6YFd6lFsqC5xkde80jjwgiTYUVRZTcIoQhOM0RbHNQh/7Ozb1FHyAw+0AA5lteujmDBnX0HAMckenzs2o3sx8UJ1RhxIgRvIcsu7N2HQ32XE0DQMYhpg6nFHE108lBX4LTUHiwTJObWAO26N5pvNJIQpO4ieEqu+rqJ7yIcCw2VqV7ueBMVx+K4V/XKjBV+NPbRW9bG4PSEFa3wO9zM4hgU7xc4/mxKc5zNlcwtaLJB4GNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVCCAv1Rt4OmFTTiLeggU3Ox37ckkuuhliEc7wfg+vk=;
 b=Xwup60rsPqlvjM8qE0SeeL7fYj+XIYz35uC+t6eFZLA0BOTJiHELIut4fadmUaYQGAHBGx/nrBprLiXQpZQCgq4ruhEHi5xV6FtdLPZRIiO2xa5ayR7JJsKCNSWY7pDXdR2rBNoQB6b2OdcMZ9QkEm5zBRQNbneBT6GhXpFzRSlgAmTcKgTNXtlkVrNGLqvneVQRyrsX+jrZEyzdnJxsXGbBbotnZ5LpBfmBFCW4uIvBi5LMWYrPTQ+AvWUD1fCItlMe4Pf5fodnTq5I6LoU9XWJEYUhL0DsvkATNQOCm8trl0qUJk1H/CuYL5HOJttkoCVthksmq0Dt87QZa6kDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=astro-kom.de; dmarc=pass action=none header.from=astro-kom.de;
 dkim=pass header.d=astro-kom.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astro-kom.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVCCAv1Rt4OmFTTiLeggU3Ox37ckkuuhliEc7wfg+vk=;
 b=WRtn0Ic+zcGV/9huNpNdZW0769EldzDMI8Nw55wZEQRnTptCUGF6NlpKpZYhTdxcjqqQSaOLzLyneLaLf2ZKSXnqopC+sBInPdF9KC6JMMJF60w3/sn//Im/7Y5u+KijkXj+J1e4Adf1JJiwJqcZELfRavamTe1eq8V1lh5tB7NsP4PC5eSOD5o/BGfSP8fbxw41pSmgAWPzdg/s54IcTZ1pCZ2Jo5vpEt2erIDyGrIfol34v7ElDv8jSPVLNX/f8A35BSAYEL/RNjOfcuvvpv0CiIyjibrgK1740IQt9af/YLolSzS6FGWURAJSw6fMoyTbHFdPXTe9EnSbu+gLpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=astro-kom.de;
Received: from AM0PR02MB4226.eurprd02.prod.outlook.com (2603:10a6:208:dd::31)
 by AS4PR02MB8183.eurprd02.prod.outlook.com (2603:10a6:20b:4ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 16:07:11 +0000
Received: from AM0PR02MB4226.eurprd02.prod.outlook.com
 ([fe80::7cf8:3151:61c2:e660]) by AM0PR02MB4226.eurprd02.prod.outlook.com
 ([fe80::7cf8:3151:61c2:e660%6]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 16:07:10 +0000
Content-Type: multipart/alternative;
 boundary="------------XivlFnDksvyBnI1ptA4ov1eu"
Message-ID: <94c18370-5149-8d5a-32ad-8c72a76e38e0@astro-kom.de>
Date: Tue, 16 May 2023 18:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: de-DE
To: bitbake-devel@lists.openembedded.org
From: "Dr. Arno Baumfalk" <a.baumfalk@astro-kom.de>
Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AM0PR02MB4226.eurprd02.prod.outlook.com
 (2603:10a6:208:dd::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4226:EE_|AS4PR02MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: dc418cf9-153c-402c-f8f5-08db56279ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XvDAxmv4b965P4TKvJj82TesU3TJ4ssyOTRojTEvOC/DMSdVI1ylGGl7+82JVT0ePmYalCzeyUafwH9GFJHGTR8I99wvsKoo7v3UVhhN/dkOmk/4/vWPOGLNcSfTxQB+YKKhhAqFxrtZljEv5RZ/n+99cgy30s0rT1LjP1gYr36e5wvvHj5rT/ohwMBDdELshZtmUVAw/ZiTTBIz1jQqNvvcibHl0GC1hdxTJHrOHRUYPD1tuwnhvWBMRxMsahbnGnzDAEgHY75Vf83a8TYzx67mqtmhVBPjY9LBrcex3ZKhr5p+v0BCuqE9+v/mb6WtkMefv5YAudtXnMlnSHi5gYEveZgkqTmk1vuGxrEklsCykZ/G3YomTNXDEGPS0FHj4D1dgc/hEGYULXM8t9PSsHMGzcci7Mg970u2gOuWtmnE3A5jmfrrt93dvP4TK7CxhTrbdnyoTrfRK3AM7PdC4VSIGQM9l61YcOF69jZPkwIGROHGJ+d7gVzsD/2gPO/iRXQdcHrLDwHaESuE3+iVK1m3cZdzMpPkNrUnCvAxY5UbIQo6CSMAByDbBGBCIDRzZU7nhXmYEZx0zP+hLUDJ/Y2N7OgmGG8/cnzUcQbKt2GJnaARo56In4qIJB1Iuy9BeViPyeEZ7WzyQQSWfxCvrY3Ft6hagIV2U1r3+fhOuAyu3XIWYw7UyS8hy7yXGhuJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4226.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39840400004)(366004)(451199021)(2906002)(41300700001)(15974865002)(86362001)(31696002)(186003)(478600001)(6916009)(66556008)(66946007)(66476007)(31686004)(5660300002)(8676002)(316002)(8936002)(52116002)(166002)(6486002)(38100700002)(53546011)(6506007)(6512007)(83380400001)(33964004)(66574015)(2616005)(36756003)(73022008)(41612003)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHhYaHVUQlgzTkRKZTczYXMvV3Y0Nm9pWDlaWWQ3dVlHV210R1gvaGxLWkE2?=
 =?utf-8?B?Vlo0UkFVUUdhQ2FITmkxY1luNy9iUUZYRktKbmRGQVQzdk43QUtvZDJUM3dl?=
 =?utf-8?B?ck4rR1ZiUUlPK2ptdXFSUkhROElkMXVBUlp2N094dWJvSHhXVHNNWWFBakFm?=
 =?utf-8?B?VTZMaCtJMkN4QSsrU3ZFWjNkc1QyS0MzYktqbDJGKzZiUVdaZm94TUo0VlV4?=
 =?utf-8?B?ajN5MVN6T2xOcUVlSVc0VndITmhabHFuam40cHFiSE4yWjZmdG5HT0JzTy9N?=
 =?utf-8?B?Mm5OM2xPSUlrL2VjcjRhdy9XRkNBYi9sMi9JemdCckVjd2d1cDY0UkFtUWhR?=
 =?utf-8?B?SG94ZnRmMi9FV2NFblMzeENPMFNwWHg0VVZJcWh3WW1WTmRYN3J5WmtUMjBU?=
 =?utf-8?B?dk5sQVNyOHdDTmdHME1CN0gxUThnaXJydXFOME9nWnJuTTJjRzdkVWE4VHhi?=
 =?utf-8?B?c0ltWjI1Y2NlQkNlK3RKS3BPTVlzaUlmZHZySUhBOGNtb3ZPa0pTUEo2WjRZ?=
 =?utf-8?B?NHJmZWFMSFBrb2dkZTJoVms3YWNWMktZRmo1ZkNZbVBVaVFBN29xcG5kazZi?=
 =?utf-8?B?bEpHdzNmRTUwd295OGdIK3pPbDlFa3ovRmQ3bjA0aThXZ0I0Rzc3bzZwenVE?=
 =?utf-8?B?aHlKZnY0ZDB2am9NZ3hsQXo4VmJpN3M2VnZXVDVNbXE0djFLM0hLU2lwTkJY?=
 =?utf-8?B?WGF1clRrQityajNySmd4amFjSTFsbVUyUklwRFdXcERqMFBWc0IrTm9ydHhR?=
 =?utf-8?B?RUF0dEQ3a2d3M1ovelZ3RGl2Qk43MWZxL0dMdCtTcEhFc2M3OGt1TkRneWxt?=
 =?utf-8?B?WEJDbTZ4QXpDSlFOMytZTmNUdFBaRzlZRTFyT0h5YUVHNG9EZFFLZ1JLWDN0?=
 =?utf-8?B?Y1lCUkdTZlEzaVZyU3JESzNZN1Jqc1B3YVU0WFQrM2NGVWtJSW11czExb0pu?=
 =?utf-8?B?a1ZMbDFEek1wWjZWNEVWTWZJOFp1VGVtNStUYzNUVUVFdSsxNkRicWp0ZmIx?=
 =?utf-8?B?RXM3cGFCVlNLTmNVVUhxUHpaWmIwM3U3UzMxMVF3WGdYamxOSGJQQ1dWQUFm?=
 =?utf-8?B?d0VtcXBOTm5pRnMrQWdFaS9wK0p2WktBaWtBR20wK2QvZXlHQStpMm5Sazho?=
 =?utf-8?B?bDRXWmZGVDR2ZU16bk5LRzlpVTlGdkVndUg4VG00R3hGUk5xYUlEUVhvUm51?=
 =?utf-8?B?ZGVENUJRbTU2bUpDRFd0MFkvY2JJcFp4Y0RYbG53RzczeFhrSFk5aURnVGl6?=
 =?utf-8?B?SitzVHp1SnlNd3VzcndYb29rakFvZFdzVkdjZk5NRWxLSFdHb2xLbkVvWmZ1?=
 =?utf-8?B?UDBGUXFvN1FIT2tqR0RFcW52NFg5K3ZnN2JSQk0wSUZxeTdpcnF5Qk50Y2NB?=
 =?utf-8?B?MzBsMFlBRHpMYklPUUo1YW14aGIzYzVEWDRVeWxZcVpxQyt4dHpxOU1iVmFT?=
 =?utf-8?B?Yk1CSXV5NktEa0RwWk9HV2tYeUc4RmVWUnhyM05iVXNYRmFvbmRBcUEyWTVN?=
 =?utf-8?B?cHlNQjlQN3pPVXhhbHl5eTdiK2UvaTFyVGdmWE9BbXNTcE00MGU0bDFlM1ZD?=
 =?utf-8?B?ejNMV0dkTjIyeVVTZnFuSU5mQnFXY1ZuK3pvT2RETDI3WndvYm5hRFZRcGNj?=
 =?utf-8?B?QjBwYW9DNC9NOFB3Y0l6cWJSQllDRzJ2QVl2d09NMFZaVVVuNFBmNGpQRjZI?=
 =?utf-8?B?RElySGpNMnc3TDBNaldtWEVIMkp2cUIxMkhlU3BGVlJqZUtoeDZZNEJDWGNY?=
 =?utf-8?B?NUxrVmN4RjB5ZmpzSVZlWTFnMHQyRy80bUZzU3dBZ2xXQWIwb2pIT0RrNU1h?=
 =?utf-8?B?aWM4YW5WeGRNcFZFWnRSTHByZlAxZC9yUFd0dUtMV01qZGViMXhvbDY1dzY0?=
 =?utf-8?B?M0NSVmkzZFpMdEFWVzVYUjJ6YXhHNVJZS1QxOU1BT0tpWEJucUQyYkJjRWxy?=
 =?utf-8?B?UFJsbEpQRW0zTVFFODJReGNtMTFUaWJJNmlQYytuTTJqUGdZQ1A0cDlvSUxQ?=
 =?utf-8?B?Y01TMjVjVDFNYzlGQjNRWkJra1ErZ2cxOURmSFhrcXp3cjR6cFV0UmZuTzZv?=
 =?utf-8?B?ODhlQVZtQ2pNa0RuU1VROFh3RE1xWjlzckRMc3hRVVNzOU5oWk95WUhpdUZN?=
 =?utf-8?B?Q0Z5TGpBQWE0R01Lc0xZRU9RaFFOSkdPZ2I1ZHgxMk5ZaU9ZSTJrQVc1VE11?=
 =?utf-8?Q?N85GeAjMn+Ib7aKVkOd2Xv/BnCSqd1wMnHttCG5uJTcf?=
X-OriginatorOrg: astro-kom.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc418cf9-153c-402c-f8f5-08db56279ad2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4226.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:07:10.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3b05cd54-01bf-41a6-8a3a-9c3c3ffacd90
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM5rJkg78le99FB+xEGIMUJEYtvb0Duef0/85WW18SI5iBUk1lzruE4xac5XGboDoMMXk6LCg00sqGIAiSkxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8183
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 May 2023 16:07:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14790

--------------XivlFnDksvyBnI1ptA4ov1eu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From acafbccb32510bca036894287afbe83765bc2d30 Mon Sep 17 00:00:00 2001
From: Arno Baumfalk <a.baumfalk@astro-kom.de>
Date: Tue, 16 May 2023 17:18:26 +0200
Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME

When the user configures the TMPDIR variable in a way that it contains 
$HOME (in local.conf), the DataSmart (d) object's PATH variable will 
also contain $HOME.

As the NpmEnvironment patches HOME with a temporary directory, further 
evaluation of PATH will become invalid an the build breaks with an error 
(npm not found).

As countermeasure PATH is evaluated *before* patching HOME.

Signed-off-by: Arno Baumfalk <a.baumfalk@astro-kom.de>
---
  bitbake/lib/bb/fetch2/npm.py | 1 +
  1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index 8a179a339a..e6d0598f5d 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -103,6 +103,7 @@ class NpmEnvironment(object):
          """Run npm command in a controlled environment"""
          with tempfile.TemporaryDirectory() as tmpdir:
              d = bb.data.createCopy(self.d)
+            d.setVar("PATH", d.getVar("PATH"))  # PATH might contain 
$HOME - evaluate it before patching
              d.setVar("HOME", tmpdir)

              if not workdir:
-- 
2.26.2
-- 

Mit freundlichen Grüßen

*ASTRO Strobel **
*Kommunikationssysteme GmbH

Dr. Arno Baumfalk
Entwicklung

	


Telefon: 	+49 (0) 2204 405 228
Fax: 	+49 (0) 2204 405 220
eMail 	a.baumfalk@astro-kom.de <3D"mailto:a.ba=>
Internet: 	www.astro-kom.de <3D"http://www.=>


Folgen Sie uns<https://www.facebook.com/astrostrobel/>

ASTRO Strobel Kommunikationssysteme GmbH
Olefant 1-3 · 51427 Bergisch Gladbach
Geschäftsführer: Herbert Strobel
Registergericht Köln HRB 46271
Steuer-Nr. 204/5710/0569 · USt.ID-Nr. DE 121980384

Die Informationen in dieser eMail zusammen mit allen Anlagen sind streng 
vertraulich. Sie sind ausschließlich für den Gebrauch des rechtmäßigen 
Empfängers bestimmt. Jegliche Weitergabe ohne unsere ausdrückliche 
Genehmigung ist verboten und kann strafrechtlich verfolgt werden. 
Sollten Sie nicht der vorgesehene Empfänger dieser E-Mail sein, 
informieren Sie uns bitte unter 02204/405-0 oder leiten Sie die Mail an 
uns zurück _a.baumfalk@astro-kom.de_. Löschen Sie bitte die E-Mail von 
Ihrem System. Die ASTRO Strobel Kommunikationssysteme GmbH trägt weder 
die Verantwortung für die richtige und vollständige Übertragung dieser 
E-Mail noch für die Verzögerungen in der Übertragung.

The information and attachments in this e-mail are strictly 
confidential. They are for the exclusive use of the legitimate 
recipient. Any transfer without our express approval is prohibited and 
can be prosecuted. If you are not the destined recipient of this e-mail, 
please inform us by phone number +49 2204 405 0 or send the e-mail back 
to a.baumfalk@astro-kom.de. Please delete this e-mail from your system. 
The ASTRO Strobel Kommunikationssysteme GmbH is neither responsible for 
the complete transmission of this e-mail nor for transmission delays.

--------------XivlFnDksvyBnI1ptA4ov1eu
Content-Type: multipart/related;
 boundary="------------uIRGDoaKXEOmjI8bVD0IwmKX"

--------------uIRGDoaKXEOmjI8bVD0IwmKX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>From acafbccb32510bca036894287afbe83765bc2d30 Mon Sep 17 00:00:00
      2001<br>
      From: Arno Baumfalk <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:a.baumfalk@astro-kom.de">&lt;a.baumfalk@astro-kom.de&gt;</a><br>
      Date: Tue, 16 May 2023 17:18:26 +0200<br>
      Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME<br>
      <br>
      When the user configures the TMPDIR variable in a way that it
      contains $HOME (in local.conf), the DataSmart (d) object's PATH
      variable will also contain $HOME.<br>
      <br>
      As the NpmEnvironment patches HOME with a temporary directory,
      further evaluation of PATH will become invalid an the build breaks
      with an error (npm not found).<br>
      <br>
      As countermeasure PATH is evaluated *before* patching HOME.<br>
      <br>
      Signed-off-by: Arno Baumfalk <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:a.baumfalk@astro-kom.de">&lt;a.baumfalk@astro-kom.de&gt;</a><br>
      ---<br>
      &nbsp;bitbake/lib/bb/fetch2/npm.py | 1 +<br>
      &nbsp;1 file changed, 1 insertion(+)<br>
      <br>
      diff --git a/bitbake/lib/bb/fetch2/npm.py
      b/bitbake/lib/bb/fetch2/npm.py<br>
      index 8a179a339a..e6d0598f5d 100644<br>
      --- a/bitbake/lib/bb/fetch2/npm.py<br>
      +++ b/bitbake/lib/bb/fetch2/npm.py<br>
      @@ -103,6 +103,7 @@ class NpmEnvironment(object):<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;Ru=
n npm command in a controlled environment&quot;&quot;&quot;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with tempfile.Tempor=
aryDirectory() as tmpdir:<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; d =3D bb.data.createCopy(self.d)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
.setVar(&quot;PATH&quot;, d.getVar(&quot;PATH&quot;))&nbsp; # PATH might
      contain $HOME - evaluate it before patching<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; d.setVar(&quot;HOME&quot;, tmpdir)<br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if not workdir:<br>
      -- <br>
      2.26.2<br>
      -- <br>
    </p>
    <div class=3D"moz-signature">
     =20
      <meta name=3D"ProgId" content=3D"Word.Document">
      <meta name=3D"Generator" content=3D"Microsoft Word 15">
      <meta name=3D"Originator" content=3D"Microsoft Word 15">
      <link rel=3D"File-List" href=3D"signatur_70-Dateien/filelist.xml">
      <link rel=3D"Edit-Time-Data" href=3D"signatur_70-Dateien/editdata.mso=
">
      <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Torsten Hinz</o:Author>
  <o:LastAuthor>Torsten Hinz</o:LastAuthor>
  <o:Revision>3</o:Revision>
  <o:Created>2017-01-10T10:56:00Z</o:Created>
  <o:LastSaved>2017-01-10T11:57:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>269</o:Words>
  <o:Characters>1700</o:Characters>
  <o:Lines>14</o:Lines>
  <o:Paragraphs>3</o:Paragraphs>
  <o:CharactersWithSpaces>1966</o:CharactersWithSpaces>
  <o:Version>15.00</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
      <link rel=3D"themeData" href=3D"signatur_70-Dateien/themedata.thmx">
      <link rel=3D"colorSchemeMapping" href=3D"signatur_70-Dateien/colorsch=
ememapping.xml">
      <!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:Zoom>80</w:Zoom>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:HyphenationZone>21</w:HyphenationZone>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>DE</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val=3D"Cambria Math"/>
   <m:brkBin m:val=3D"before"/>
   <m:brkBinSub m:val=3D"&#45;-"/>
   <m:smallFrac m:val=3D"off"/>
   <m:dispDef/>
   <m:lMargin m:val=3D"0"/>
   <m:rMargin m:val=3D"0"/>
   <m:defJc m:val=3D"centerGroup"/>
   <m:wrapIndent m:val=3D"1440"/>
   <m:intLim m:val=3D"subSup"/>
   <m:naryLim m:val=3D"undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"false"
  DefSemiHidden=3D"false" DefQFormat=3D"false" DefPriority=3D"99"
  LatentStyleCount=3D"371">
  <w:LsdException Locked=3D"false" Priority=3D"0" QFormat=3D"true" Name=3D"=
Normal"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"=
heading 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"heading 9"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 6"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 7"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 8"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index 9"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"toc 9"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Normal Indent"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"footnote text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"annotation text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"header"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"footer"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"index heading"/>
  <w:LsdException Locked=3D"false" Priority=3D"35" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"caption"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"table of figures"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"envelope address"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"envelope return"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"footnote reference"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"annotation reference"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"line number"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"page number"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"endnote reference"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"endnote text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"table of authorities"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"macro"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"toa heading"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Bullet"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Number"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Bullet 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Bullet 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Bullet 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Bullet 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Number 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Number 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Number 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Number 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"10" QFormat=3D"true" Name=3D=
"Title"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Closing"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Signature"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"Default Paragraph Font"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text Indent"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Continue"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Continue 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Continue 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Continue 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"List Continue 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Message Header"/>
  <w:LsdException Locked=3D"false" Priority=3D"11" QFormat=3D"true" Name=3D=
"Subtitle"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Salutation"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Date"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text First Indent"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text First Indent 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Note Heading"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text Indent 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Body Text Indent 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Block Text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Hyperlink"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"FollowedHyperlink"/>
  <w:LsdException Locked=3D"false" Priority=3D"22" QFormat=3D"true" Name=3D=
"Strong"/>
  <w:LsdException Locked=3D"false" Priority=3D"20" QFormat=3D"true" Name=3D=
"Emphasis"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Document Map"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Plain Text"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"E-mail Signature"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Top of Form"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Bottom of Form"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Normal (Web)"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Acronym"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Address"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Cite"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Code"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Definition"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Keyboard"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Preformatted"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Sample"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Typewriter"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"HTML Variable"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Normal Table"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"annotation subject"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"No List"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Outline List 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Outline List 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Outline List 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Simple 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Simple 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Simple 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Classic 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Classic 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Classic 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Classic 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Colorful 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Colorful 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Colorful 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Columns 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Columns 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Columns 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Columns 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Columns 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 6"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 7"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Grid 8"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 4"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 5"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 6"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 7"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table List 8"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table 3D effects 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table 3D effects 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table 3D effects 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Contemporary"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Elegant"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Professional"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Subtle 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Subtle 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Web 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Web 2"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Web 3"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Balloon Text"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"Table Grid"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"tr=
ue"
   Name=3D"Table Theme"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Placeholder =
Text"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" QFormat=3D"true" Name=3D"=
No Spacing"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Revision"/>
  <w:LsdException Locked=3D"false" Priority=3D"34" QFormat=3D"true"
   Name=3D"List Paragraph"/>
  <w:LsdException Locked=3D"false" Priority=3D"29" QFormat=3D"true" Name=3D=
"Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"30" QFormat=3D"true"
   Name=3D"Intense Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accen=
t 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accen=
t 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1=
 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2=
 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent=
 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading=
 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Ac=
cent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"19" QFormat=3D"true"
   Name=3D"Subtle Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"21" QFormat=3D"true"
   Name=3D"Intense Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"31" QFormat=3D"true"
   Name=3D"Subtle Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"32" QFormat=3D"true"
   Name=3D"Intense Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"33" QFormat=3D"true" Name=3D=
"Book Title"/>
  <w:LsdException Locked=3D"false" Priority=3D"37" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" Name=3D"Bibliography"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true"
   UnhideWhenUsed=3D"true" QFormat=3D"true" Name=3D"TOC Heading"/>
  <w:LsdException Locked=3D"false" Priority=3D"41" Name=3D"Plain Table 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"42" Name=3D"Plain Table 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"43" Name=3D"Plain Table 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"44" Name=3D"Plain Table 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"45" Name=3D"Plain Table 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"40" Name=3D"Grid Table Light=
"/>
  <w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Lig=
ht"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k"/>
  <w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Col=
orful"/>
  <w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Col=
orful"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dar=
k Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Lig=
ht"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k"/>
  <w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Col=
orful"/>
  <w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Col=
orful"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"46"
   Name=3D"List Table 1 Light Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Acc=
ent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dar=
k Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"51"
   Name=3D"List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"52"
   Name=3D"List Table 7 Colorful Accent 6"/>
 </w:LatentStyles>
</xml><![endif]-->
      <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:1;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073786111 1 0 415 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0cm;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	mso-themecolor:hyperlink;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#954F72;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;
	mso-header-margin:35.4pt;
	mso-footer-margin:35.4pt;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Normale Tabelle";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-fareast-language:EN-US;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1"/>
 </o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"font-family:&quot;Arial&quot;,sans-serif;co=
lor:#595959">Mit
            freundlichen Gr=C3=BC=C3=9Fen<u1:p></u1:p></span><span style=3D=
"font-size:12.0pt;mso-fareast-font-family:&quot;Times
            New Roman&quot;"><o:p></o:p></span></p>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"font-family:&quot;Arial&quot;,sans-serif;co=
lor:gray"><u1:p>&nbsp;</u1:p></span></p>
        <u1:p></u1:p>
        <table class=3D"MsoNormalTable" style=3D"border-collapse:collapse;m=
so-yfti-tbllook:1184;mso-padding-alt:0cm
          0cm 0cm 0cm" cellspacing=3D"0" cellpadding=3D"0" border=3D"0">
          <tbody>
            <tr style=3D"mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-las=
trow:yes;
              height:82.1pt">
              <td style=3D"width:158.05pt;padding:0cm 0cm 0cm 0cm;
                height:82.1pt" width=3D"211" valign=3D"top">
                <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso=
-margin-bottom-alt:auto;
                  line-height:105%"><b><span style=3D"font-family:&quot;Ari=
al&quot;,sans-serif;color:red;
                      mso-fareast-language:EN-US">ASTRO
                      Strobel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; </span></b><b><span style=3D"font-size:10.0pt;line-height:105%;=
font-family:
                      &quot;Arial&quot;,sans-serif;color:navy;mso-fareast-l=
anguage:EN-US"><br>
                    </span></b><span style=3D"font-size:10.0pt;line-height:=
105%;font-family:&quot;Arial&quot;,sans-serif;
                    color:red;mso-fareast-language:EN-US">Kommunikationssys=
teme
                    GmbH</span><span style=3D"mso-fareast-language:EN-US"><=
o:p></o:p></span></p>
                <u1:p></u1:p>
                <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso=
-margin-bottom-alt:auto;
                  line-height:105%"><span style=3D"font-size:10.0pt;line-he=
ight:105%;font-family:
&quot;Arial&quot;,sans-serif;color:red;mso-fareast-language:EN-US"><u1:p>&n=
bsp;</u1:p></span><span style=3D"mso-fareast-language:EN-US"><o:p></o:p></s=
pan></p>
                <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso=
-margin-bottom-alt:auto;
                  line-height:105%"><span style=3D"font-family:&quot;Arial&=
quot;,sans-serif;color:#1F497D;
                    mso-fareast-language:EN-US">Dr. Arno <span class=3D"Spe=
llE">Baumfalk</span><br>
                  </span><span style=3D"font-size:10.0pt;line-height:105%;f=
ont-family:&quot;Arial&quot;,sans-serif;
                    color:#595959;mso-fareast-language:EN-US">Entwicklung
                  </span><span style=3D"mso-fareast-language:EN-US"><o:p></=
o:p></span></p>
              </td>
              <td style=3D"width:263.6pt;padding:0cm 0cm 0cm 0cm;
                height:82.1pt" width=3D"351" valign=3D"top">
                <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso=
-margin-bottom-alt:auto;
                  line-height:105%"><span style=3D"mso-no-proof:yes"><!--[i=
f gte vml 1]><v:shapetype
   id=3D"_x0000_t75" coordsize=3D"21600,21600" o:spt=3D"75" o:preferrelativ=
e=3D"t"
   path=3D"m@4@5l@4@11@9@11@9@5xe" filled=3D"f" stroked=3D"f">
   <v:stroke joinstyle=3D"miter"/>
   <v:formulas>
    <v:f eqn=3D"if lineDrawn pixelLineWidth 0"/>
    <v:f eqn=3D"sum @0 1 0"/>
    <v:f eqn=3D"sum 0 0 @1"/>
    <v:f eqn=3D"prod @2 1 2"/>
    <v:f eqn=3D"prod @3 21600 pixelWidth"/>
    <v:f eqn=3D"prod @3 21600 pixelHeight"/>
    <v:f eqn=3D"sum @0 0 1"/>
    <v:f eqn=3D"prod @6 1 2"/>
    <v:f eqn=3D"prod @7 21600 pixelWidth"/>
    <v:f eqn=3D"sum @8 21600 0"/>
    <v:f eqn=3D"prod @7 21600 pixelHeight"/>
    <v:f eqn=3D"sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok=3D"f" gradientshapeok=3D"t" o:connecttype=3D"rect"=
/>
   <o:lock v:ext=3D"edit" aspectratio=3D"t"/>
  </v:shapetype><v:shape id=3D"Grafik_x0020_4" o:spid=3D"_x0000_i1027" type=
=3D"#_x0000_t75"
   style=3D'width:105pt;height:80.25pt;visibility:visible;mso-wrap-style:sq=
uare'>
   <v:imagedata src=3D"data:image/jpeg;filename=3Dimage001.jpg;base64,/9j/4=
AAQSkZJRgABAQEBLAEsAAD/4Qp/RXhpZgAATU0AKgAAAAgABwESAAMAAAABAAEAAAEaAAUAAAAB=
AAAAYgEbAAUAAAABAAAAagEoAAMAAAABAAIAAAExAAIAAAALAAAAcgEyAAIAAAAUAAAAfodpAAQ=
AAAABAAAAkgAAANQAAAEsAAAAAQAAASwAAAABR0lNUCAyLjguMAAAMjAxNzowMToxMCAxNjo1Nz=
o1MgAABZAAAAcAAAAEMDIxMKAAAAcAAAAEMDEwMKABAAMAAAAB//8AAKACAAQAAAABAAAAZKADA=
AQAAAABAAAATwAAAAAABgEDAAMAAAABAAYAAAEaAAUAAAABAAABIgEbAAUAAAABAAABKgEoAAMA=
AAABAAIAAAIBAAQAAAABAAABMgICAAQAAAABAAAJRQAAAAAAAABIAAAAAQAAAEgAAAAB/9j/4AA=
QSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC=
4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyM=
jIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAA+AE8DASIAAhEB=
AxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF=
9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3OD=
k6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp=
6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA=
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSE=
xBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSE=
lKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0t=
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
yd2f//Z/+EM+mh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSfv=
u78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSd=
hZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMT=
k5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiB4bWxuczpkYz0na=
HR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8nPgogIDxkYzpmb3JtYXQ+aW1hZ2UvanBl=
ZzwvZGM6Zm9ybWF0PgogIDxkYzp0aXRsZT4KICAgPHJkZjpBbHQ+CiAgICA8cmRmOmxpIHhtbDp=
sYW5nPSd4LWRlZmF1bHQnPngtZGVmYXVsdDwvcmRmOmxpPgogICA8L3JkZjpBbHQ+CiAgPC9kYz=
p0aXRsZT4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24geG1sbnM6eG1wP=
SdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvJz4KICA8eG1wOk1ldGFkYXRhRGF0ZT4yMDE3=
LTAxLTA1VDEyOjUwOjExKzAxOjAwPC94bXA6TWV0YWRhdGFEYXRlPgogIDx4bXA6TW9kaWZ5RGF=
0ZT4yMDE3LTAxLTA1VDEyOjUwOjExKzAxOjAwPC94bXA6TW9kaWZ5RGF0ZT4KICA8eG1wOkNyZW=
F0ZURhdGU+MjAxNy0wMS0wNVQxMjo0ODoyMiswMjowMDwveG1wOkNyZWF0ZURhdGU+CiAgPHhtc=
DpDcmVhdG9yVG9vbD5BZG9iZSBJbGx1c3RyYXRvciBDUzYgKFdpbmRvd3MpPC94bXA6Q3JlYXRv=
clRvb2w+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOnhtcE1=
NPSdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vJz4KICA8eG1wTU06SW5zdGFuY2VJRD=
54bXAuaWlkOjRCMzVERjFDM0REM0U2MTFBRUE2QjlCODE5M0JGNzYwPC94bXBNTTpJbnN0YW5jZ=
UlEPgogIDx4bXBNTTpEb2N1bWVudElEIHJkZjpyZXNvdXJjZT0neG1wLmRpZDo0QTM1REYxQzNE=
RDNFNjExQUVBNkI5QjgxOTNCRjc2MCcgLz4KICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnV=
1aWQ6NUQyMDg5MjQ5M0JGREIxMTkxNEE4NTkwRDMxNTA4Qzg8L3htcE1NOk9yaWdpbmFsRG9jdW=
1lbnRJRD4KICA8eG1wTU06UmVuZGl0aW9uQ2xhc3M+cHJvb2Y6cGRmPC94bXBNTTpSZW5kaXRpb=
25DbGFzcz4KICA8eG1wTU06RGVyaXZlZEZyb20gcmRmOnBhcnNlVHlwZT0nUmVzb3VyY2UnPgog=
IDwveG1wTU06RGVyaXZlZEZyb20+CiAgPHhtcE1NOkhpc3Rvcnk+CiAgIDxyZGY6U2VxPgogICA=
8L3JkZjpTZXE+CiAgPC94bXBNTTpIaXN0b3J5PgogPC9yZGY6RGVzY3JpcHRpb24+CgogPHJkZj=
pEZXNjcmlwdGlvbiB4bWxuczppbGx1c3RyYXRvcj0naHR0cDovL25zLmFkb2JlLmNvbS9pbGx1c=
3RyYXRvci8xLjAvJz4KICA8aWxsdXN0cmF0b3I6VHlwZT5Eb2N1bWVudDwvaWxsdXN0cmF0b3I6=
VHlwZT4KICA8aWxsdXN0cmF0b3I6U3RhcnR1cFByb2ZpbGU+UHJpbnQ8L2lsbHVzdHJhdG9yOlN=
0YXJ0dXBQcm9maWxlPgogPC9yZGY6RGVzY3JpcHRpb24+CgogPHJkZjpEZXNjcmlwdGlvbiB4bW=
xuczp4bXBUUGc9J2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC90L3BnLyc+CiAgPHhtcFRQZ=
zpIYXNWaXNpYmxlT3ZlcnByaW50PkZhbHNlPC94bXBUUGc6SGFzVmlzaWJsZU92ZXJwcmludD4K=
ICA8eG1wVFBnOkhhc1Zpc2libGVUcmFuc3BhcmVuY3k+RmFsc2U8L3htcFRQZzpIYXNWaXNpYmx=
lVHJhbnNwYXJlbmN5PgogIDx4bXBUUGc6TlBhZ2VzPjE8L3htcFRQZzpOUGFnZXM+CiAgPHhtcF=
RQZzpNYXhQYWdlU2l6ZSByZGY6cGFyc2VUeXBlPSdSZXNvdXJjZSc+CiAgPC94bXBUUGc6TWF4U=
GFnZVNpemU+CiAgPHhtcFRQZzpQbGF0ZU5hbWVzPgogICA8cmRmOkJhZz4KICAgIDxyZGY6bGk+=
TWFnZW50YTwvcmRmOmxpPgogICAgPHJkZjpsaT5ZZWxsb3c8L3JkZjpsaT4KICAgIDxyZGY6bGk=
+QmxhY2s8L3JkZjpsaT4KICAgPC9yZGY6QmFnPgogIDwveG1wVFBnOlBsYXRlTmFtZXM+CiA8L3=
JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOnhtcEc9J2h0dHA6Ly9uc=
y5hZG9iZS5jb20veGFwLzEuMC9nLyc+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2Ny=
aXB0aW9uIHhtbG5zOnBkZj0naHR0cDovL25zLmFkb2JlLmNvbS9wZGYvMS4zLyc+CiAgPHBkZjp=
Qcm9kdWNlcj5BZG9iZSBQREYgbGlicmFyeSAxMC4wMTwvcGRmOlByb2R1Y2VyPgogPC9yZGY6RG=
VzY3JpcHRpb24+CgogPHJkZjpEZXNjcmlwdGlvbiB4bWxuczpwaG90b3Nob3A9J2h0dHA6Ly9uc=
y5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8nPgogIDxwaG90b3Nob3A6Q29sb3JNb2RlPjQ8L3Bo=
b3Rvc2hvcDpDb2xvck1vZGU+CiAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPkNvYXRlZCBGT0dSQTM=
5IChJU08gMTI2NDctMjoyMDA0KTwvcGhvdG9zaG9wOklDQ1Byb2ZpbGU+CiA8L3JkZjpEZXNjcm=
lwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOmV4aWY9J2h0dHA6Ly9ucy5hZG9iZS5jb=
20vZXhpZi8xLjAvJz4KICA8ZXhpZjpPcmllbnRhdGlvbj5Ub3AtbGVmdDwvZXhpZjpPcmllbnRh=
dGlvbj4KICA8ZXhpZjpYUmVzb2x1dGlvbj4zMDAsMDAwMDwvZXhpZjpYUmVzb2x1dGlvbj4KICA=
8ZXhpZjpZUmVzb2x1dGlvbj4zMDAsMDAwMDwvZXhpZjpZUmVzb2x1dGlvbj4KICA8ZXhpZjpSZX=
NvbHV0aW9uVW5pdD5JbmNoPC9leGlmOlJlc29sdXRpb25Vbml0PgogIDxleGlmOlNvZnR3YXJlP=
kFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpPC9leGlmOlNvZnR3YXJlPgogIDxleGlmOkRh=
dGVUaW1lPjIwMTc6MDE6MDUgMTI6NTA6MTE8L2V4aWY6RGF0ZVRpbWU+CiAgPGV4aWY6Q29tcHJ=
lc3Npb24+SlBFRyBjb21wcmVzc2lvbjwvZXhpZjpDb21wcmVzc2lvbj4KICA8ZXhpZjpYUmVzb2=
x1dGlvbj43MjwvZXhpZjpYUmVzb2x1dGlvbj4KICA8ZXhpZjpZUmVzb2x1dGlvbj43MjwvZXhpZ=
jpZUmVzb2x1dGlvbj4KICA8ZXhpZjpSZXNvbHV0aW9uVW5pdD5JbmNoPC9leGlmOlJlc29sdXRp=
b25Vbml0PgogIDxleGlmOkV4aWZWZXJzaW9uPkV4aWYgVmVyc2lvbiAyLjE8L2V4aWY6RXhpZlZ=
lcnNpb24+CiAgPGV4aWY6Rmxhc2hQaXhWZXJzaW9uPkZsYXNoUGl4IFZlcnNpb24gMS4wPC9leG=
lmOkZsYXNoUGl4VmVyc2lvbj4KICA8ZXhpZjpDb2xvclNwYWNlPlVuY2FsaWJyYXRlZDwvZXhpZ=
jpDb2xvclNwYWNlPgogIDxleGlmOlBpeGVsWERpbWVuc2lvbj4xMDA8L2V4aWY6UGl4ZWxYRGlt=
ZW5zaW9uPgogIDxleGlmOlBpeGVsWURpbWVuc2lvbj43OTwvZXhpZjpQaXhlbFlEaW1lbnNpb24=
+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCjwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldC=
BlbmQ9J3InPz4K/9sAQwADAgIDAgIDAwMDBAMDBAUIBQUEBAUKBwcGCAwKDAwLCgsLDQ4SEA0OE=
Q4LCxAWEBETFBUVFQwPFxgWFBgSFBUU/9sAQwEDBAQFBAUJBQUJFA0LDRQUFBQUFBQUFBQUFBQU=
FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU/8IAEQgATwBkAwERAAIRAQMRAf/=
EABwAAAAHAQEAAAAAAAAAAAAAAAADBAUGBwgCAf/EABwBAAEFAQEBAAAAAAAAAAAAAAACAwQFBg=
EHCP/aAAwDAQACEAMQAAABhGU+hyuq8O+c74d8Dk7eNh52cIkkipc3Yc9nZsBiDK/Q3IoAAI64m=
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3D" o:title=3D"astro70"/>
  </v:shape><![endif]--><!--[if !vml]--><img src=3D"cid:part1.JIoTMPMw.GWZq=
00SM@astro-kom.de" v:shapes=3D"Grafik_x0020_4" width=3D"140" height=3D"107"=
><!--[endif]--></span><span style=3D"mso-fareast-language:EN-US"><o:p></o:p=
></span></p>
              </td>
            </tr>
          </tbody>
        </table>
        <br>
        <table style=3D"3D&quot;font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans=3D" -serif;color:#595959?=3D"">
          <tbody>
            <tr>
              <td>Telefon:</td>
              <td>+49&nbsp;(0) 2204 405 228</td>
            </tr>
            <tr>
              <td>Fax:</td>
              <td>+49&nbsp;(0) 2204 405 220</td>
            </tr>
            <tr>
              <td>eMail</td>
              <td><a class=3D"3D&quot;moz-txt-link-abbreviated&quot;" href=
=3D"3D&quot;mailto:a.ba=3D" umfalk@astro-kom.de?=3D"">a.baumfalk@astro-kom.=
de</a></td>
            </tr>
            <tr>
              <td>Internet:</td>
              <td><a class=3D"3D&quot;moz-txt-link-abbreviated&quot;" href=
=3D"3D&quot;http://www.=3D" astro-kom.de?=3D"">www.astro-kom.de</a></td>
            </tr>
          </tbody>
        </table>
        <br>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif;color:#595959">Folgen
            Sie
            uns</span><span style=3D"font-size:10.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;
            color:#1F497D">&nbsp; </span><a href=3D"https://www.facebook.co=
m/astrostrobel/"><span style=3D"color:windowtext;mso-no-proof:yes;text-deco=
ration:none;text-underline:none"><!--[if gte vml 1]><v:shape id=3D"Grafik_x=
0020_5" o:spid=3D"_x0000_i1026"
 type=3D"#_x0000_t75" href=3D"https://www.facebook.com/astrostrobel/" style=
=3D'width:24pt;
 height:24pt;visibility:visible;mso-wrap-style:square' o:button=3D"t">
 <v:imagedata src=3D"data:image/jpeg;filename=3Dimage003.jpg;base64,/9j/4AA=
QSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMgIyIoLT=
kwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09PT09P=
T09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAAbABsDASIAAhEB=
AxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF=
9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3OD=
k6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp=
6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA=
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSE=
xBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSE=
lKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0t=
ba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDr=
L29nluWLMQahjkuJZUijbLudqiuen1S8hunUS7lHZhmtrwprFpNqKR6mALlpALbaOp969OVNxje=
xyqabsbtzo8tlatNLfjzFXcEx19qfa6ndm2jIbAx0NReM77TLVCtwzDUDETb4Bxmubsrq5eziaS=
Zy5XnFYxi5w5mW5KMrIw704u2J4yOM1Y0Aj/hJdN5H+uFb/iC0gj1ydFiULndjHc1mmCNFLogVl=
6EdRXUqilG3cwcLSL/xII/tiz6f6s1StHVLWMMcEL0NRr++UvLl3XoWOSK9D0nTLM6VbE28ZJQH=
JFYzmqUFFmkY88mz/9k=3D" o:title=3D"facebook"/>
</v:shape><![endif]--><!--[if !vml]--><span style=3D"mso-ignore:vglayout"><=
img src=3D"cid:part2.wZXonNsV.pvkNZzi0@astro-kom.de" v:shapes=3D"Grafik_x00=
20_5" width=3D"32" height=3D"32" border=3D"0"></span><!--[endif]--></span><=
/a><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif=
;color:#1F497D">&nbsp;&nbsp;<span style=3D"mso-no-proof:yes"><!--[if gte vm=
l 1]><v:shape id=3D"Grafik_x0020_6"
 o:spid=3D"_x0000_i1025" type=3D"#_x0000_t75" style=3D'width:24pt;height:24=
pt;
 visibility:visible;mso-wrap-style:square'>
 <v:imagedata src=3D"data:image/jpeg;filename=3Dimage005.jpg;base64,/9j/4AA=
QSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMgIyIoLT=
kwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09PT09P=
T09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAAbABsDASIAAhEB=
AxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF=
9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3OD=
k6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp=
6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA=
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSE=
xBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSE=
lKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0t=
ba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwBi=
y3d3fGKFnlnlfAGeSa0YNGubmO5eLVIWa1GZ0Xkp/jWTpuqnR9civtnmCNyrJ3YHrj3rchg/smy=
1HxBpkU80VxmJYHXDRZ6s3qBXlwinufWVpyjZR02t5vt5aGF9rkPSViOx9auW+oXawIEupVUDgA=
02bTtPh8N293Dfo9w7tkBfv99vtVSByYE+lTZpmjlGa0XXsTeG7myg1yc37pHvRlt5nGVjf1NWt=
MuLzQdVa81DVIprfawkRHDicHoAKwbuJFvrmMKNiyEAVEI0H8Iq02vkZSjGd30a/r0FMgZ3YLsV=
nLKnZcmrUD/uV+lVdo9K2tOsbeWwheSIMxHJ/GlGLbLq1Yxjdn//2Q=3D=3D" o:title=3D"go=
ogle"/>
</v:shape><![endif]--><!--[if !vml]--><img src=3D"cid:part3.yPpRaTUW.3pZu7b=
RG@astro-kom.de" v:shapes=3D"Grafik_x0020_6" width=3D"32" height=3D"32" bor=
der=3D"0"><!--[endif]--></span></span><o:p></o:p></p>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&qu=
ot;,sans-serif;color:#1F497D"><u1:p>&nbsp;</u1:p></span></p>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"color:#1F497D">&nbsp;</span><o:p></o:p></p>
        <u1:p></u1:p>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;margin-bott=
om:12.0pt"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif;color:#595959">ASTRO
            Strobel Kommunikationssysteme GmbH<br>
            <span class=3D"SpellE">Olefant</span> 1-3 =C2=B7 51427 Bergisch
            Gladbach<br>
            Gesch=C3=A4ftsf=C3=BChrer: Herbert Strobel<br>
            Registergericht K=C3=B6ln HRB 46271<br>
            Steuer-Nr. 204/5710/0569 =C2=B7 USt.ID-Nr. DE 121980384<br>
            <br>
          </span><span style=3D"font-size:8.0pt;font-family:&quot;Arial&quo=
t;,sans-serif;color:#595959">Die
            Informationen in dieser <span class=3D"SpellE">eMail</span>
            zusammen mit allen
            Anlagen sind streng vertraulich. Sie sind ausschlie=C3=9Flich f=
=C3=BCr
            den Gebrauch des
            rechtm=C3=A4=C3=9Figen Empf=C3=A4ngers bestimmt. Jegliche Weite=
rgabe ohne
            unsere ausdr=C3=BCckliche
            Genehmigung ist verboten und kann strafrechtlich verfolgt
            werden. Sollten Sie
            nicht der vorgesehene Empf=C3=A4nger dieser E-Mail sein,
            informieren Sie&nbsp;uns
            bitte unter 02204/405-0 oder leiten Sie die Mail an uns
            zur=C3=BCck <u><a href=3D"mailto:a.baumfalk@astro-kom.de" class=
=3D"moz-txt-link-freetext">a.baumfalk@astro-kom.de</a></u>.
            L=C3=B6schen Sie bitte die E-Mail von Ihrem System. Die ASTRO
            Strobel
            Kommunikationssysteme GmbH tr=C3=A4gt weder die Verantwortung f=
=C3=BCr
            die richtige und
            vollst=C3=A4ndige =C3=9Cbertragung dieser E-Mail noch f=C3=BCr =
die
            Verz=C3=B6gerungen in der
            =C3=9Cbertragung.<u1:p></u1:p></span></p>
        <p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-=
bottom-alt:auto"><span style=3D"font-size:8.0pt;font-family:&quot;Arial&quo=
t;,sans-serif;color:#595959;
            mso-ansi-language:EN-GB" lang=3D"EN-GB">The information and
            attachments in this e-mail are
            strictly confidential. They are for the exclusive use of the
            legitimate
            recipient. Any transfer without our express approval is
            prohibited and can be
            prosecuted. If you are not the destined recipient of this
            e-mail, please inform
            us by phone number +49 2204 405 0 or send the e-mail back to
            <a href=3D"mailto:a.baumfalk@astro-kom.de" class=3D"moz-txt-lin=
k-freetext">a.baumfalk@astro-kom.de</a>.
            Please
            delete this e-mail from your system. The ASTRO Strobel <span cl=
ass=3D"SpellE">Kommunikationssysteme</span>
            GmbH is neither responsible for the complete transmission of
            this e-mail nor
            for transmission delays.</span><span style=3D"mso-ansi-language=
:EN-GB" lang=3D"EN-GB"><o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span style=3D"mso-ansi-language:EN-GB" lang=
=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
      </div>
    </div>
  </body>
</html>=

--------------uIRGDoaKXEOmjI8bVD0IwmKX
Content-Type: image/jpeg; name="image001.jpg"
Content-Disposition: inline; filename="image001.jpg"
Content-Id: <part1.JIoTMPMw.GWZq00SM@astro-kom.de>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEBLAEsAAD/4Qp/RXhpZgAATU0AKgAAAAgABwESAAMAAAABAAEAAAEaAAUA
AAABAAAAYgEbAAUAAAABAAAAagEoAAMAAAABAAIAAAExAAIAAAALAAAAcgEyAAIAAAAUAAAAfodp
AAQAAAABAAAAkgAAANQAAAEsAAAAAQAAASwAAAABR0lNUCAyLjguMAAAMjAxNzowMToxMCAxNjo1
Nzo1MgAABZAAAAcAAAAEMDIxMKAAAAcAAAAEMDEwMKABAAMAAAAB//8AAKACAAQAAAABAAAAZKAD
AAQAAAABAAAATwAAAAAABgEDAAMAAAABAAYAAAEaAAUAAAABAAABIgEbAAUAAAABAAABKgEoAAMA
AAABAAIAAAIBAAQAAAABAAABMgICAAQAAAABAAAJRQAAAAAAAABIAAAAAQAAAEgAAAAB/9j/4AAQ
SkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4n
ICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAA+AE8DASIAAhEBAxEB
/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQID
AAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RF
RkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKz
tLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEB
AQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdh
cRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldY
WVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPE
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
LzEuMC8APD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQn
Pz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJk
Zj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpE
ZXNjcmlwdGlvbiB4bWxuczpkYz0naHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8nPgog
IDxkYzpmb3JtYXQ+aW1hZ2UvanBlZzwvZGM6Zm9ybWF0PgogIDxkYzp0aXRsZT4KICAgPHJkZjpB
bHQ+CiAgICA8cmRmOmxpIHhtbDpsYW5nPSd4LWRlZmF1bHQnPngtZGVmYXVsdDwvcmRmOmxpPgog
ICA8L3JkZjpBbHQ+CiAgPC9kYzp0aXRsZT4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVz
Y3JpcHRpb24geG1sbnM6eG1wPSdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvJz4KICA8eG1w
Ok1ldGFkYXRhRGF0ZT4yMDE3LTAxLTA1VDEyOjUwOjExKzAxOjAwPC94bXA6TWV0YWRhdGFEYXRl
PgogIDx4bXA6TW9kaWZ5RGF0ZT4yMDE3LTAxLTA1VDEyOjUwOjExKzAxOjAwPC94bXA6TW9kaWZ5
RGF0ZT4KICA8eG1wOkNyZWF0ZURhdGU+MjAxNy0wMS0wNVQxMjo0ODoyMiswMjowMDwveG1wOkNy
ZWF0ZURhdGU+CiAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBJbGx1c3RyYXRvciBDUzYgKFdpbmRv
d3MpPC94bXA6Q3JlYXRvclRvb2w+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0
aW9uIHhtbG5zOnhtcE1NPSdodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vJz4KICA8eG1w
TU06SW5zdGFuY2VJRD54bXAuaWlkOjRCMzVERjFDM0REM0U2MTFBRUE2QjlCODE5M0JGNzYwPC94
bXBNTTpJbnN0YW5jZUlEPgogIDx4bXBNTTpEb2N1bWVudElEIHJkZjpyZXNvdXJjZT0neG1wLmRp
ZDo0QTM1REYxQzNERDNFNjExQUVBNkI5QjgxOTNCRjc2MCcgLz4KICA8eG1wTU06T3JpZ2luYWxE
b2N1bWVudElEPnV1aWQ6NUQyMDg5MjQ5M0JGREIxMTkxNEE4NTkwRDMxNTA4Qzg8L3htcE1NOk9y
aWdpbmFsRG9jdW1lbnRJRD4KICA8eG1wTU06UmVuZGl0aW9uQ2xhc3M+cHJvb2Y6cGRmPC94bXBN
TTpSZW5kaXRpb25DbGFzcz4KICA8eG1wTU06RGVyaXZlZEZyb20gcmRmOnBhcnNlVHlwZT0nUmVz
b3VyY2UnPgogIDwveG1wTU06RGVyaXZlZEZyb20+CiAgPHhtcE1NOkhpc3Rvcnk+CiAgIDxyZGY6
U2VxPgogICA8L3JkZjpTZXE+CiAgPC94bXBNTTpIaXN0b3J5PgogPC9yZGY6RGVzY3JpcHRpb24+
CgogPHJkZjpEZXNjcmlwdGlvbiB4bWxuczppbGx1c3RyYXRvcj0naHR0cDovL25zLmFkb2JlLmNv
bS9pbGx1c3RyYXRvci8xLjAvJz4KICA8aWxsdXN0cmF0b3I6VHlwZT5Eb2N1bWVudDwvaWxsdXN0
cmF0b3I6VHlwZT4KICA8aWxsdXN0cmF0b3I6U3RhcnR1cFByb2ZpbGU+UHJpbnQ8L2lsbHVzdHJh
dG9yOlN0YXJ0dXBQcm9maWxlPgogPC9yZGY6RGVzY3JpcHRpb24+CgogPHJkZjpEZXNjcmlwdGlv
biB4bWxuczp4bXBUUGc9J2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC90L3BnLyc+CiAgPHht
cFRQZzpIYXNWaXNpYmxlT3ZlcnByaW50PkZhbHNlPC94bXBUUGc6SGFzVmlzaWJsZU92ZXJwcmlu
dD4KICA8eG1wVFBnOkhhc1Zpc2libGVUcmFuc3BhcmVuY3k+RmFsc2U8L3htcFRQZzpIYXNWaXNp
YmxlVHJhbnNwYXJlbmN5PgogIDx4bXBUUGc6TlBhZ2VzPjE8L3htcFRQZzpOUGFnZXM+CiAgPHht
cFRQZzpNYXhQYWdlU2l6ZSByZGY6cGFyc2VUeXBlPSdSZXNvdXJjZSc+CiAgPC94bXBUUGc6TWF4
UGFnZVNpemU+CiAgPHhtcFRQZzpQbGF0ZU5hbWVzPgogICA8cmRmOkJhZz4KICAgIDxyZGY6bGk+
TWFnZW50YTwvcmRmOmxpPgogICAgPHJkZjpsaT5ZZWxsb3c8L3JkZjpsaT4KICAgIDxyZGY6bGk+
QmxhY2s8L3JkZjpsaT4KICAgPC9yZGY6QmFnPgogIDwveG1wVFBnOlBsYXRlTmFtZXM+CiA8L3Jk
ZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOnhtcEc9J2h0dHA6Ly9ucy5h
ZG9iZS5jb20veGFwLzEuMC9nLyc+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0
aW9uIHhtbG5zOnBkZj0naHR0cDovL25zLmFkb2JlLmNvbS9wZGYvMS4zLyc+CiAgPHBkZjpQcm9k
dWNlcj5BZG9iZSBQREYgbGlicmFyeSAxMC4wMTwvcGRmOlByb2R1Y2VyPgogPC9yZGY6RGVzY3Jp
cHRpb24+CgogPHJkZjpEZXNjcmlwdGlvbiB4bWxuczpwaG90b3Nob3A9J2h0dHA6Ly9ucy5hZG9i
ZS5jb20vcGhvdG9zaG9wLzEuMC8nPgogIDxwaG90b3Nob3A6Q29sb3JNb2RlPjQ8L3Bob3Rvc2hv
cDpDb2xvck1vZGU+CiAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPkNvYXRlZCBGT0dSQTM5IChJU08g
MTI2NDctMjoyMDA0KTwvcGhvdG9zaG9wOklDQ1Byb2ZpbGU+CiA8L3JkZjpEZXNjcmlwdGlvbj4K
CiA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOmV4aWY9J2h0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8x
LjAvJz4KICA8ZXhpZjpPcmllbnRhdGlvbj5Ub3AtbGVmdDwvZXhpZjpPcmllbnRhdGlvbj4KICA8
ZXhpZjpYUmVzb2x1dGlvbj4zMDAsMDAwMDwvZXhpZjpYUmVzb2x1dGlvbj4KICA8ZXhpZjpZUmVz
b2x1dGlvbj4zMDAsMDAwMDwvZXhpZjpZUmVzb2x1dGlvbj4KICA8ZXhpZjpSZXNvbHV0aW9uVW5p
dD5JbmNoPC9leGlmOlJlc29sdXRpb25Vbml0PgogIDxleGlmOlNvZnR3YXJlPkFkb2JlIFBob3Rv
c2hvcCBDUzYgKFdpbmRvd3MpPC9leGlmOlNvZnR3YXJlPgogIDxleGlmOkRhdGVUaW1lPjIwMTc6
MDE6MDUgMTI6NTA6MTE8L2V4aWY6RGF0ZVRpbWU+CiAgPGV4aWY6Q29tcHJlc3Npb24+SlBFRyBj
b21wcmVzc2lvbjwvZXhpZjpDb21wcmVzc2lvbj4KICA8ZXhpZjpYUmVzb2x1dGlvbj43MjwvZXhp
ZjpYUmVzb2x1dGlvbj4KICA8ZXhpZjpZUmVzb2x1dGlvbj43MjwvZXhpZjpZUmVzb2x1dGlvbj4K
ICA8ZXhpZjpSZXNvbHV0aW9uVW5pdD5JbmNoPC9leGlmOlJlc29sdXRpb25Vbml0PgogIDxleGlm
OkV4aWZWZXJzaW9uPkV4aWYgVmVyc2lvbiAyLjE8L2V4aWY6RXhpZlZlcnNpb24+CiAgPGV4aWY6
Rmxhc2hQaXhWZXJzaW9uPkZsYXNoUGl4IFZlcnNpb24gMS4wPC9leGlmOkZsYXNoUGl4VmVyc2lv
bj4KICA8ZXhpZjpDb2xvclNwYWNlPlVuY2FsaWJyYXRlZDwvZXhpZjpDb2xvclNwYWNlPgogIDxl
eGlmOlBpeGVsWERpbWVuc2lvbj4xMDA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogIDxleGlmOlBp
eGVsWURpbWVuc2lvbj43OTwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiA8L3JkZjpEZXNjcmlwdGlv
bj4KCjwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9J3InPz4K/9sAQwADAgID
AgIDAwMDBAMDBAUIBQUEBAUKBwcGCAwKDAwLCgsLDQ4SEA0OEQ4LCxAWEBETFBUVFQwPFxgWFBgS
FBUU/9sAQwEDBAQFBAUJBQUJFA0LDRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU
FBQUFBQUFBQUFBQUFBQU/8IAEQgATwBkAwERAAIRAQMRAf/EABwAAAAHAQEAAAAAAAAAAAAAAAAD
BAUGBwgCAf/EABwBAAEFAQEBAAAAAAAAAAAAAAACAwQFBgEHCP/aAAwDAQACEAMQAAABhGU+hyuq
8O+c74d8Dk7eNh52cIkkipc3Yc9nZsBiDK/Q3IoAAI64m46+OV2h7Ly73nGzkte5GVdZsexyoAAA
AZNz3tcAjabQtp5fclnglC24zGtonFuyEuTibnZDIrAACBQtJkui9td1wdo6TwFStoAAruu1HvSD
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

--------------uIRGDoaKXEOmjI8bVD0IwmKX
Content-Type: image/jpeg; name="image003.jpg"
Content-Disposition: inline; filename="image003.jpg"
Content-Id: <part2.wZXonNsV.pvkNZzi0@astro-kom.de>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMg
IyIoLTkwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAAbABsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDrL29n
luWLMQahjkuJZUijbLudqiuen1S8hunUS7lHZhmtrwprFpNqKR6mALlpALbaOp969OVNxjexyqab
sbtzo8tlatNLfjzFXcEx19qfa6ndm2jIbAx0NReM77TLVCtwzDUDETb4Bxmubsrq5eziaSZy5XnF
Yxi5w5mW5KMrIw704u2J4yOM1Y0Aj/hJdN5H+uFb/iC0gj1ydFiULndjHc1mmCNFLogVl6EdRXUq
ilG3cwcLSL/xII/tiz6f6s1StHVLWMMcEL0NRr++UvLl3XoWOSK9D0nTLM6VbE28ZJQHJFYzmqUF
FmkY88mz/9k=

--------------uIRGDoaKXEOmjI8bVD0IwmKX
Content-Type: image/jpeg; name="image005.jpg"
Content-Disposition: inline; filename="image005.jpg"
Content-Id: <part3.yPpRaTUW.3pZu7bRG@astro-kom.de>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMg
IyIoLTkwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAAbABsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwBiy3d3
fGKFnlnlfAGeSa0YNGubmO5eLVIWa1GZ0Xkp/jWTpuqnR9civtnmCNyrJ3YHrj3rchg/smy1HxBp
kU80VxmJYHXDRZ6s3qBXlwinufWVpyjZR02t5vt5aGF9rkPSViOx9auW+oXawIEupVUDgA02bTtP
h8N293Dfo9w7tkBfv99vtVSByYE+lTZpmjlGa0XXsTeG7myg1yc37pHvRlt5nGVjf1NWtMuLzQdV
a81DVIprfawkRHDicHoAKwbuJFvrmMKNiyEAVEI0H8Iq02vkZSjGd30a/r0FMgZ3YLsVnLKnZcmr
UD/uV+lVdo9K2tOsbeWwheSIMxHJ/GlGLbLq1Yxjdn//2Q==

--------------uIRGDoaKXEOmjI8bVD0IwmKX--

--------------XivlFnDksvyBnI1ptA4ov1eu--

