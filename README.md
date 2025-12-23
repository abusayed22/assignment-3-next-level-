# Vehicle Rental Management System

## Project Overview
This project implements a relational database for a **Vehicle Rental System** using PostgreSQL. The system manages three core entities: **Users**, **Vehicles**, and **Bookings**. It is designed to handle user roles, track vehicle availability, and manage the lifecycle of a rental booking from 'Pending' to 'Completed'.

## Database Schema
The schema is built around a **One-to-Many** relationship between Users and Bookings, and a **Many-to-One** relationship between Bookings and Vehicles.

### Core Entities:
- **Users**: Stores customer and admin profiles with role-based access control.
- **Vehicles**: Manages the fleet, including status tracking (Available, Rented, Maintenance).
- **Bookings**: The central transactional table linking users to specific vehicles for a defined date range.
