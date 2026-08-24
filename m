Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC501C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 11:15:05 +0000 (UTC)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14240.1787570095472890116
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 04:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=M8wu4FAM;
 spf=pass (domain: cisco.com, ip: 173.37.142.95, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5326; q=dns/txt;
  s=iport01; t=1787570095; x=1788779695;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xl/w9PrqwdtjLrcBQswi00puMK2updWWxXSjulz3M/s=;
  b=M8wu4FAMgl6CD4ZEqIZBg2KcCsCEuYkLlafqy4RQxZfEfOpNql1BeN0r
   jegimml0V9HESuByUIn50FDDCsYOMlQBcUX0hhZ8DFdo87gOR81oAwMcP
   qEzXe98Vz3zEJyN2rlc1ZiP+pOnQ1A9ZRuxeeg92u4/E8Nrja8y9eYPXm
   B8MEwf2YIPvipbpek+PeVJjo/lVoguD5K0Z32TsuyVef3jkdIIiN26wg2
   dmXXXSb6Qo18zMWDXf6Vimt8NAjVntqpdvG11u34pFGmmpNkXy0t5B3oq
   kALWVo7IaeiLxy/wGGZYzVm2qUxpOAN5XONlfFv/7clRrWpaqvTJSLBeI
   w==;
X-CSE-ConnectionGUID: EuSsdrM+QxmKWkdt5Vtx5Q==
X-CSE-MsgGUID: d3jSELZITPuyKQSpSfAsRg==
X-IPAS-Result: =?us-ascii?q?A0DiAgCPJoxq/48QJK1agS6BK4FuUxZyAoEhSYgjA4Urh?=
 =?us-ascii?q?liCIZ4egX4PAQEBDQIxIAQBAYUFAo1sAiY1CA4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFgQ4Thk8BDIdsAX8nBBuCe4J0AwECt0QCiUsaN3iBNIEB4?=
 =?us-ascii?q?C0BCxQBgTiIXgGFeIR8JxuCDYEVQoMnhEWEE4IwBIMuhESBF41/gUocA1ksA?=
 =?us-ascii?q?VUTFwsHBYFmAyovLW4yHYEjPhc1WBsGBYEdgSiEECMZNnyBCV6BKyllEheBC?=
 =?us-ascii?q?YIHAoJaggUCAUlDDgdHIgttPTcUGQMEgTUFjlQfgXpGBwEVXhoBKxc5QQcII?=
 =?us-ascii?q?zpCDyykPKF7CoQejCKVcBeFW6UQAZkII6NohQ0CBAIEBQIQAQEGgWkBOoFZc?=
 =?us-ascii?q?BWDIglKGQ+YB8Y1eT0BAQcCBw4DC4FokX4BAQ?=
IronPort-PHdr: A9a23:MInPMRyFqsHUpETXCzPsngc9DxPP8539OgoTr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:InE4qKrD+CXzCEHyxQ4DfHAESSxeBmJEZBIvgKrLsJaIsI4StFCzt
 garIBnVOa3fZ2Ojc9tzatyx8kJT6pCEzIc1HVM9ri43E35HpePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrT8k835ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0stqOnpC7
 9lbESAITS+Ai/7r/q6rF9A506zPLOGzVG8eknhkyTecCbMtRorOBv2Uo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtMYH49tL/Aan3XaCNDtl+TvrEf6GnIxws327/oWDbQUozTFZgIwB3J/
 Qoq+Uz1WRMhGfit6Aa972OPv9TXpi3SQ7gdQejQGvlCxQf7KnYoIBcXSVGyovT8hkOgVtZ3L
 00P5jFoqrA/8kGuRNTxUxC05nmesXYht8F4Guk+7kSJj6HT+QvcXjZCRT9aY9tgv8gzLdA36
 mK0cxrSLWUHmJWeSGmW8fGfqjbaBMTfBTVqifMsJefd3+TenQ==
IronPort-HdrOrdr: A9a23:pO8MW6qWjAJNe7icDjPPZnwaV5s4LNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H8BEDhex/hHO1OkPUs1NCZLUTbUQqTXctfBOTZskbd8kHFh4pgPM
 RbAuRD4b/LfCJHZK/BiWHSfadDsby6GcuT9IHjJgJWPHlXgtZbnn5E42igYypLbTgDL6AUUL
 Cb4c1KrSehf3M4UuSXb0NuY8Hz4/fwuNbDexApOz4LgTPisRqYrJLqGRmR2RkTFwhI3aoj9m
 b9lQn47LWIsv2wyBPQvlWjoKi+nuGP9vJzQOi3zuQFIDTljQilIK57XaeZgTwzqOazrH43jd
 jluX4bToVOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCvBGmZlSfnLimgodVZBHoe
 F2NlCixt9q5CD77WDADh/zJlZXf3+P0DgfeCgo/jpiuMUlGeZsRMckjTxo+d87bVzHAcYcYa
 dTJfCZwupKelWHaH2clGxuzNuwGkkXJH69MxA/Ugj/6UkNoJi/pHFon/D2kho7heMAYogB6O
 LePqtykrZSCscQcKJmHe8EBdC6E2rXXHv3QSuvyHncZdY60kj22ujKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34BF3Wu4pjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeX/
 qoIppZD/LqMGOrE4dU2A/1XYVUNBAlIYUok8d+X0jLrtPAK4XsuOCeePHPJKD1GTJhQW/7Cm
 trZkmGGCyB1DHfZpbVummiZ5q2QD2OwXtZKtmow9Qu
X-Talos-CUID: =?us-ascii?q?9a23=3AtGeCFWo6gVbbZUPSddiwIUXmUe04SWbR1lKTGl+?=
 =?us-ascii?q?9KllqRKHId0OApZoxxg=3D=3D?=
X-Talos-MUID: 9a23:PxDfYQQZkTo8kmnHRXTg3zNZGeNawpiWFVEuqK4egMetLhZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2026 11:14:54 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-06.cisco.com (Postfix) with ESMTPS id 9A19F18000116
	for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 11:14:54 +0000 (GMT)
X-CSE-ConnectionGUID: QDZCidysSCqkK1/w2m76HA==
X-CSE-MsgGUID: dOnpaqSbREOyj4FmMfOkDA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,240,1779148800"; 
   d="scan'208";a="84257237"
Received: from mail-westus3azon11012052.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.52])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2026 11:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZHJwNjLO6xaAQI41leaYWdZHFN6R7e8sYDrNk2yHa3UuquYkMcn1/B90+cbxNkg8caUvPhBOZRH5lH4gArRhg60nohmB/bBGUuHeB5JfuyrX7GUo+621dYWH+mA1xwxo37n1roA4KZ09Z1VP+Rv6peMPZrHkNXG/iYeVNOVy/GvuO3iQIilB7IjMWTtK356zkaPRnNgNZ2+mitYylvUKl8p1YQV6/ZaYwlLkcDyQryMytCToHzKXIDjtpUMzlSX9uivmXJFX3tDBHct4NkiT1hL6sOAaSVGh5LaOYVJszEm4Qe164zSZNcfC6E6xiERQP+Vka6yz+kDT5BcDFg+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl/w9PrqwdtjLrcBQswi00puMK2updWWxXSjulz3M/s=;
 b=cabOWCUVqKhPplPCyBSI0Uc25sKy+U2LIYMDYlirvoiFJbkDIlm4QZlddFprVWLszJvze28fFGVleR3zWpmL8GYHicUPB5AYru5IwU/YgXN8pHyhXBhkfX6on5A4QVLVTM5oubleKWdp4xpfc7yLkdbSq6/pb4jf1Xtz87Z3OFh6v+9v2s61LgDPag9sQot0g4Bk31Aff7XGfsyvelsRR5Uo9UMZ8K5hDiIGlbYM1Dohe2vVhVT1Lr/jzmkjNUjqFWlhjdgkp0eg5K3Ow7A/5YCrwLZsUivK1KNskel/QyPd9xRYBKeH+pKEE5NMHqobmJ7akcoI8qNyzM88A2tFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by IA3PR11MB138852.namprd11.prod.outlook.com (2603:10b6:208:549::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:14:52 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:14:51 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/git: replace stale clones when using premirrors
Thread-Topic: [PATCH] fetch2/git: replace stale clones when using premirrors
Thread-Index: AQHdM7k6U+ZE35+6pU6fW7r4ql32Lg==
Date: Mon, 24 Aug 2026 11:14:51 +0000
Message-ID: 
 <DM6PR11MB396228CA1F541EEEB9C9F04CCBA02@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|IA3PR11MB138852:EE_
x-ms-office365-filtering-correlation-id: 014c3bbe-025f-4914-477f-08df01d0eb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|3023799007|56012099006|10067099003|11063799006|18002099003;
x-microsoft-antispam-message-info: 
 A8eZCEBz8HkJ3LbxeTiE57AG03ir4cE8YOJAW2BQ23DrphJ8CKEwkIUSbVTMOH40gt1Ytvw3DCVzI4a2vUicrxPkwV/aOjfkX3fFHqZzfNuN3CffTb8P6XhAghNzHpSStMV436tcDRIPQqyFvG6ISYbrtGGLD73JmZYkKzZ575PUvQgqr78AAGYAPnQ7vWg4Gv+4FhgBfCwZQs56rivfWP6PxLdeOtM9KieuLdJ1ApiDxMY6A6kcgn/mCJu4cG9YgP4ZUzQRCj7TC7LJB2goWn1K5Z/0ImhTSgJeMAb6rOy/COFHU8draUb6BxECQ+gPtS0HfPmTLSXBsNNyW7Af6IqP0vbwZ8AWBOAh8EbUJtUR+UB6oitm1q3mFOFFSQZSqjc6g3ItcR4i3atCo+iVWmR5fit+sNDWqCd9Uf790MGLQtJKalf7e1C0CbI1+TQJKRTo3OUk2bj6Huqz2APBauCbG9e1sv1RfwdXFQmmk973pT8eI01UyYu0TmMjMhIVF/HaJRbJ7mcvMa0AWgOm9lFPBUORpLmHNWgZqbKQTnwex0RdOdRe7ZtH7hBDaZnvxaBs76rJmzoOU8GGK259L95WNcZYKuE7Oqm5WQS2vb+/lelxsSGJy9XoCYPPtxNdRTzckKgNrX8qLbModn/S+eloHXjJdYbp+CsWKHoQqAWvRVwRdJz/GYvCk7fLJ134CStsVJvqNZzqyaxD4k0dgqzOVQxjVn4hWuTMiofbTe4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?1fWHXLt1BCy34xpUzBTe+Kxl8NZ8dRMc8hFyhHEyA8HlkvGeq5AzHMwJxO?=
 =?iso-8859-1?Q?scPoMpyZGMe2zbwx6rj5VRWnbkkPg7asat9Gj/0q6KLpHDVOBJtv1j9cTg?=
 =?iso-8859-1?Q?wiBpKXMtIyYeFPYoec+tZl4PZVCEVfJm8C2tkzW7s6WTGH+9taV/m5/wXo?=
 =?iso-8859-1?Q?UEYtCj2LwXlB23a/KQ5WRU3Z2Bmv1wAOPH/tA53zABzHzoeuVB95ltc74B?=
 =?iso-8859-1?Q?JRkqJ4xjaEXH29ANhqkJg49nGsCqdLRUEQ4zNHfImntp1KNnydPct/pn4r?=
 =?iso-8859-1?Q?Gz5G3NjjWvU2VlBsjpEYEMrTb+U3YNKCez0edh7OA1G3KNUHrL4K6uSirX?=
 =?iso-8859-1?Q?e44HbNw04cBdOSuOwCKx5Yj4jiUIR7zEL9midiUcnVreLk+2+ZHvx3XCCj?=
 =?iso-8859-1?Q?b6aJuUmZnA+b4lJJbXdzKGPUORK1lhZ7YUHbuxZ3CRNN0/VmKznmpY3pnB?=
 =?iso-8859-1?Q?5peJjROkUr5hMVNAsbjEHH8ScsAIzICHXGnCTIrSR/OoUjzicyanuZxZp+?=
 =?iso-8859-1?Q?zMQZbf07BJZteO4SDB1ikjCoU1T+CzpZVv/Uuzh6BNhZtFQnlt3Y0RTLxO?=
 =?iso-8859-1?Q?uundffWI9RGQ34jWgX2sC5vtFe6hX64t+TrsLor9WM7YwjSHLAG4/rVBKs?=
 =?iso-8859-1?Q?/3YIAYsM78WfX9tMMqvQqr3FOrkcQLaxhTuwEsw+1IhZGMWXkBYomL0Dz+?=
 =?iso-8859-1?Q?MN8xAGGyXXEl0yogbMcObWBaaGSc74lk73vM/4fBgsOQLXINaaC7mTCb2z?=
 =?iso-8859-1?Q?zBUrXC0XN7psiVOAjeDBL9TlOvVR0V8lBhV5oBOye7B7fDLj4cT8fr/xnP?=
 =?iso-8859-1?Q?dwRN8zYanSb4Vr8LFstc9aDn48UFhMGk1N95IwXLxG5JfFbcoJwiMmKeJW?=
 =?iso-8859-1?Q?/1WKhyt8Y/QYpgd8Ics4i5To0DjhWeZGiWbZd65H2lw957Z7bL6Ea4km8M?=
 =?iso-8859-1?Q?E6GvxXFow51TcKhNxRHpxM5oCw+CcFjhgvXo8CYjIusOvL9mAV/nNbleTl?=
 =?iso-8859-1?Q?LAvrsMDeVJ6GBGVFfIv6FQU97eIspI4/U/4Qpn86iKdva63JhOYj+TBbP5?=
 =?iso-8859-1?Q?+4NgGLRLd6/ubZhSfDjzZsq+usB4EmrFpww3ijLarD+8H43rxvqyTEwzkK?=
 =?iso-8859-1?Q?4lRsl9EWqDob1MHvf+uXXcfF8wkJtdZhP9O5IS9bzpThzhzIqbHp/SRPph?=
 =?iso-8859-1?Q?kmXDFK5q3A9Peiz1TZ/tbCftW3r23mJf5RiRaMtwH/sTu9k8al5hYQQ25g?=
 =?iso-8859-1?Q?cgZZZo/1VhhEaYCYwc/7vAobFLocz+IUc2S+poxkfdm+MX5rBun7KmE/bn?=
 =?iso-8859-1?Q?lAvzMZlSDFMXndxQEUQ89rsJENSznAHVJ2lkQDS0pj9bNiw1zwqmGncH9p?=
 =?iso-8859-1?Q?m2wleQASH0gyZ5pxi7US7ka0KpEZ8A2JjomB4rKGOc+Qbc+DAWAcOspEOz?=
 =?iso-8859-1?Q?x51R+d+CZmHJtXDnoJ9Tn0YO8Dbai2eW/Nm9LPnplASmC4atyIs5gLvrPT?=
 =?iso-8859-1?Q?U8aGGq2uDip87wo+4VVXtUCEH04M6B22VB3xDig93AMB9yeIBDV1YelV4q?=
 =?iso-8859-1?Q?4SdtK+EzlP9qY5uqD9wsh48CoXUS4eIjre4iG9wt0e25X2HufusB3uIS5U?=
 =?iso-8859-1?Q?beQIzKDSqMT19Fl/04IgDtdPdFpTeWa2BPGecvU3bktjpgwOxH6s1fVa+8?=
 =?iso-8859-1?Q?z3OwxpU5OXCa9cZ6iFT3OK1x+/x22uI/HZ3x27n1guia9EUfr15kBycePN?=
 =?iso-8859-1?Q?DLdLay3Hg6kUIxj9dyRFGQEZgVJYC/WNUVmso9H2pcfl4M?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	WLAT0/9zaMpXL70EnAMqcnA8BLfNhf35tn0jjZpt1WJGFxFoO5VsQ1hlYydGdCNl6BfZUMYencq710/w3cppKsUSLTwpAB+rwXK4lqVQLCW+YcuVRcE8LV8/wzksk7OLCAllEe5EMRMwO90vpOTEtBu9tlz4+gkUVrrZSxhZoIPzIgSV4lCUzj+hYWlSGfD0grDsn3tGl9XyFBzn7wBqQF3GTqxAVgLiRGJhYlNpf0P2O/sXRGaiyNDFgspbBGCtbyVUdlrT2wVEUgVxw/GddZABeIT7mc3iRAxkAR0ejUuDxk3lCSahZW6AqOFhpWPbrg9i6AQkjsJVsxTs5E+tiQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014c3bbe-025f-4914-477f-08df01d0eb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 11:14:51.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C377bWVfu6zwtVv+hmVga88kLaGSNXsTNFyjesf9b5H+D3vyD15bxguYi2jXbNEWhpS95OFm2pUSJcJSpnB8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB138852
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-1.cisco.com [173.37.147.229];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 11:15:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20024

A successful premirror fetch can leave an existing clone at the original=0A=
download path even when it lacks SRCREV. The fetch is then stamped=0A=
complete before unpack rejects the stale clone.=0A=
=0A=
Pass the datastore to update_mirror_links() and remove the original=0A=
clone only when the Git validity check says it needs updating, allowing=0A=
the successful mirror to be linked.=0A=
=0A=
The new self-test creates a stale clone at the original download path=0A=
and a local premirror containing a newer SRCREV. Without the fix it=0A=
reproduces the UnpackError; with the fix it verifies that the mirror is=0A=
linked and the requested revision is unpacked.=0A=
=0A=
Tested with bitbake-selftest on Python 3.11, 3.12, 3.13, and 3.14.=0A=
=0A=
AI-Generated: OpenAI Codex=0A=
---=0A=
 lib/bb/fetch2/__init__.py |  4 ++--=0A=
 lib/bb/fetch2/git.py      |  8 ++++++--=0A=
 lib/bb/tests/fetch.py     | 42 +++++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 50 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py=0A=
index 9cb268be..68a0225f 100644=0A=
--- a/lib/bb/fetch2/__init__.py=0A=
+++ b/lib/bb/fetch2/__init__.py=0A=
@@ -1150,7 +1150,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):=0A=
         # This may also be a link to a shallow archive=0A=
         # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
         # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
-        origud.method.update_mirror_links(ud, origud)=0A=
+        origud.method.update_mirror_links(ud, origud, ld)=0A=
         update_stamp(origud, ld)=0A=
         return ud.localpath=0A=
 =0A=
@@ -1692,7 +1692,7 @@ class FetchMethod(object):=0A=
             except FileExistsError:=0A=
                 pass=0A=
 =0A=
-    def update_mirror_links(self, ud, origud):=0A=
+    def update_mirror_links(self, ud, origud, d):=0A=
         # For local file:// results, create a symlink to them=0A=
         # This may also be a link to a shallow archive=0A=
         self.ensure_symlink(ud.localpath, origud.localpath)=0A=
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py=0A=
index 0bb2ea39..a1f9cb33 100644=0A=
--- a/lib/bb/fetch2/git.py=0A=
+++ b/lib/bb/fetch2/git.py=0A=
@@ -353,8 +353,12 @@ class Git(FetchMethod):=0A=
     def tarball_need_update(self, ud):=0A=
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)=0A=
 =0A=
-    def update_mirror_links(self, ud, origud):=0A=
-        super().update_mirror_links(ud, origud)=0A=
+    def update_mirror_links(self, ud, origud, d):=0A=
+        # Replace a stale clone which would prevent linking the successful=
 mirror.=0A=
+        if self.clonedir_need_update(origud, d) and os.path.exists(origud.=
localpath) \=0A=
+                and not os.path.samefile(ud.localpath, origud.localpath):=
=0A=
+            bb.utils.remove(origud.localpath, recurse=3DTrue)=0A=
+        super().update_mirror_links(ud, origud, d)=0A=
         # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
         # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
         if origud.shallow and not os.path.exists(origud.fullshallow):=0A=
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py=0A=
index a1e4b45f..65483570 100644=0A=
--- a/lib/bb/tests/fetch.py=0A=
+++ b/lib/bb/tests/fetch.py=0A=
@@ -616,6 +616,48 @@ class GitDownloadDirectoryNamingTest(FetcherTest):=0A=
         self.assertIn(self.recipe_dir, dir)=0A=
 =0A=
 =0A=
+class GitPremirrorStaleCloneTest(FetcherTest):=0A=
+=0A=
+    def test_premirror_replaces_stale_clone(self):=0A=
+        source =3D os.path.join(self.tempdir, "source")=0A=
+        os.mkdir(source)=0A=
+        self.git_init(cwd=3Dsource)=0A=
+=0A=
+        testfile =3D os.path.join(source, "testfile")=0A=
+        with open(testfile, "w") as f:=0A=
+            f.write("first\n")=0A=
+        self.git(["add", "testfile"], cwd=3Dsource)=0A=
+        self.git(["commit", "-m", "first commit"], cwd=3Dsource)=0A=
+=0A=
+        recipe_url =3D "git://upstream.invalid/project.git;branch=3Dmaster=
;protocol=3Dhttps"=0A=
+        self.d.setVar("SRCREV", self.git(["rev-parse", "HEAD"], cwd=3Dsour=
ce).strip())=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        ud =3D fetcher.ud[recipe_url]=0A=
+        ud.setup_localpath(self.d)=0A=
+        os.makedirs(os.path.dirname(ud.clonedir), exist_ok=3DTrue)=0A=
+        self.git(["clone", "--bare", "--mirror", source, ud.clonedir], cwd=
=3Dself.tempdir)=0A=
+=0A=
+        with open(testfile, "a") as f:=0A=
+            f.write("second\n")=0A=
+        self.git(["commit", "-am", "second commit"], cwd=3Dsource)=0A=
+        revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).strip()=
=0A=
+=0A=
+        self.d.setVar("SRCREV", revision)=0A=
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")=0A=
+        self.d.setVar("BB_NO_NETWORK", "1")=0A=
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=3Dfile" % (recip=
e_url, source))=0A=
+=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        ud =3D fetcher.ud[recipe_url]=0A=
+        fetcher.download()=0A=
+        fetcher.unpack(self.unpackdir)=0A=
+=0A=
+        self.assertTrue(os.path.islink(ud.clonedir))=0A=
+        unpack_revision =3D self.git(["rev-parse", "HEAD"],=0A=
+                                   cwd=3Dos.path.join(self.unpackdir, "git=
")).strip()=0A=
+        self.assertEqual(revision, unpack_revision)=0A=
+=0A=
+=0A=
 class TarballNamingTest(FetcherTest):=0A=
     def setUp(self):=0A=
         super(TarballNamingTest, self).setUp()=0A=
-- =0A=
2.55.0=0A=

