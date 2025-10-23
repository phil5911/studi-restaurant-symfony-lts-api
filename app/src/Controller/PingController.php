<?php
namespace App\Controller;

use Doctrine\DBAL\Connection;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class PingController extends AbstractController
{
    #[Route('/ping', name: 'app_ping')]
    public function ping(Connection $connection): JsonResponse
    {
        try {
            $connection->executeQuery('SELECT 1');
            return new JsonResponse(['status' => 'ok', 'db' => 'connected']);
        } catch (\Exception $e) {
            return new JsonResponse(['status' => 'error', 'db' => 'unreachable', 'message' => $e->getMessage()], 500);
        }
    }
}
